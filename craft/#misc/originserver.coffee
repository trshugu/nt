a = require("express")()
# a.use require('compression')()

a.get "/",(q,s)->
  s.status "418"
  s.end("tea pot")

# gzip対応->できない模様
a.get "/testlargetruegzip",(q,s)->
  console.time "tmp1"
  s.status "200"
  # s.set "Content-Encoding": "gzip"
  # s.set "Transfer-Encoding": "chunked"
  
  jSt = require('JSONStream').parse() 
  jSt.on "data", (d)-> s.write JSON.stringify d
  jSt.on "end", ->
    console.timeEnd "tmp1"
    s.end()
  
  jsonfile = require("fs").createReadStream "./" + "test_suzuki_ni" + ".json", encoding: "utf-8"
  jsonfile.pipe(jSt)


a.get "/testlargetrue",(q,s)->
  console.time "tmp2"
  s.status "200"
  
  jSt = require('JSONStream').parse() 
  jSt.on "data", (d)-> s.write JSON.stringify d
  jSt.on "end", ->
    console.timeEnd "tmp2"
    s.end()
  
  jsonfile = require("fs").createReadStream "./" + "test_suzuki" + ".json", encoding: "utf-8"
  jsonfile.pipe(jSt)
  


# そこそこlarge(限界がきた)
a.get "/testlarge",(q,s)->
  s.status "200"
  
  obj = {}
  obj.ichi = "one"
  obj.ni = "toe"
  obj.san = "slate"
  [0...200].forEach (i)->
    obj[i] = i.toString() + "bo"
  
  [0...100].forEach ->
    s.write JSON.stringify obj
  
  s.end()



a.get "/test",(q,s)->
  s.status "200"
  
  obj = {}
  obj.ichi = "one"
  obj.ni = "toe"
  obj.san = "slate"
  
  s.write JSON.stringify obj
  s.end()

# 拡張子付
a.get "/j(.:ext)?",(q,s)->
  console.log q.query
  console.log q.body
  console.log q.session
  console.log q.params
  console.log q.params.ext
  
  s.status "200"
  s.end("jj")

# ファイル指定など
a.get "/f/:file.:ext?",(q,s)->
  console.log q.params
  console.log q.params.file
  console.log q.params.ext
  
  s.status "200"
  s.end("ff")

a.get "/don",(q,s)->
  s.status "410"
  s.end("mu")

a.post "/pika",(q,s)->
  s.status "300"
  s.end("tyuu")
  

a.listen 3001,->
  console.log "on"


###
http = require "http"

s = http.createServer (req, res)-> 
  res.writeHead 418, "Content-Type":"text/html"
  res.end "tea pot"

s.listen 3001
###