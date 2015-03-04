###
###


# poster
h=require "http"

o = 
  uri: "http://yahoo.co.jp"
  form: {name: "testest"}
  json: true

q=h.request o,(r)->
  r.setEncoding("utf8")
  
  data = ""
  r.on 'data', (c)->
    data += c
  r.on "end",->
    console.log data
.on "error",(e)->

# getter
h.get("http://yahoo.co.jp").on 'response',(res)->
  res.setEncoding("utf8")
  res.on 'data', (c)->
    console.log c

