module.exports = (ctx, msg, next)->
  console.log "kieru"
  dp = {}
  dp.msg = msg
  
  
  console.log "1"
  ctx.body = "henkya"
  
  console.log "3"
  ctx.body = await asyn()
  console.log "4"
  # ctx.render "index", dp


asyn = -> new Promise (f,r)->
  console.log "httpp"
  req = require("http").request
    host: "google.com"
    path: "/"
    method: "GET"
    , (res)->
      res.on "data", (c)->
        # f c.toString()
        console.log  c.toString()
        console.log "kokonihakiteru"
        f "kaeta"
  
  req.on "error", (e)-> r e
  # req.write JSON.stringify 
  req.end()
