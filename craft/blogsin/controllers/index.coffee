wsse = require 'wsse'
xml2js = require 'xml2js'
request = require "request"
fs = require "fs"

rtend = "https://livedoor.blogcms.jp/atompub/"
username = ""
password = ""

token = new wsse.UsernameToken "username":username, "password": password
header =
  'Authorization': 'WSSE profile="UsernameToken"'
  'X-WSSE': token.getWSSEHeader(nonceBase64: true)
builder = new xml2js.Builder(rootName : "entry")
parseString = xml2js.parseString

module.exports = (render)-> ->
  dp = {}
  
  if @req.method == "POST" and @req.body.desc?
    if @req.files.im?
      console.log @req.files.im
      resImageXml = yield lbImagePost @req.files.im
      console.log "resImageXml:",resImageXml
      
      imgTag = yield ldMakeImgTag resImageXml
      console.log "imgTag:",imgTag
    
    content = ""
    content += imgTag if imgTag?
    content += @req.body.desc.split("\n")[1..].map((i)->i.trim()).join("<br>")
    
    entry = {}
    entry.title = @req.body.desc.split("\n")[0].trim()
    entry.content = content
    entry.updated = new Date()
    # console.log entry
    
    xml = builder.buildObject entry
    yield ldPost xml
  
  
  @body = yield render 'index', dp

ldPost = (xml)-> new Promise (f,r)->
  request.post
    uri: rtend + "/article"
    body: xml
    headers: header
    , (e,r,b)->
      if e?
        console.log "p e:", e
        r e
      else
        console.log "p b:", b
        f b

lbImagePost = (image)-> new Promise (f,r)->
  imageHeader = header
  imageHeader["Content-Type"] = image.mimetype

  require("request").post
    uri: rtend + "/image"
    body: new Buffer(fs.readFileSync(image.path))
    headers: imageHeader
    , (e,r,b)->
      if e?
        console.log "ip e:",e
        r e
      else
        console.log "ip b:",b
        f b

ldMakeImgTag = (xml)-> new Promise (f,r)->
  parseString xml, (e,d)->
    if e?
      r e
    else
      src = d.entry.content[0].$.src
      if d.entry.content[0].$.thumbnail?
        thumbnail = d.entry.content[0].$.thumbnail 
      else
        thumbnail = src
      
      tag = """
        <a href="#{src}" target="_blank">
        <img src="#{thumbnail}" width="160" height="120" border="0" hspace="5" class="pict" align="left"  />
        </a>
      """
      f tag


