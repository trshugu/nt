# cryptkey作成
getMD5Hash = -> 
  hash = require("crypto").createHash 'MD5'
  hash.update "randomToken", "utf8"
  hash.digest 'hex'

# IVの鍵作成
makeIV = ->
  iv = require("crypto").createHash 'md5'
  iv.update 'randomToken'
  iv.digest()

module.exports = (req, res)-> 
  console.log req.query
  console.log req.body
  console.log req.session
  console.log req.params
  
  # 複合
  if req.params.crypt?
    try
      decipher = require("crypto").createDecipheriv 'aes-256-cbc', getMD5Hash(), makeIV()
      decode = decipher.update req.params.crypt, 'hex', 'utf-8'
      decode += decipher.final "utf-8"
    catch
      console.log "noi"
      res.status 404 
      res.end()
      return
    
    filename = decode.split(",")[0]
    expire = decode.split(",")[1]
    
    if expire > new Date().getTime()
      console.log "有効期限内"
      console.log filename
      
      console.log "1"
      # res.header "Content-Disposition", "attachment; filename=" + filename
      res.attachment filename
      res.type "mp3"
      req.pipe(require("request")("/source/" + filename)).pipe(res)
      # res.end 200
      ###
      require("http").get("/source/" + filename).on "response", (s)->
        console.log "2"
        data = ""
        s.on "data", (c)->
          data += c
        
        s.on "end", ->
          console.log "4"
          # console.log data
          res.type "mp3"
          res.send data
      ###
      console.log "5"
    else
      console.log "有効期限ぎれ"
      res.send "passed away"
  else
    res.send "death"
