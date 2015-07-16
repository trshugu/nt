module.exports = (req, res)-> 
  client = require("redis").createClient()
  client.get "ke", (e,r)->
    if e?
      console.log "error root"
      console.log e
    else
      console.log "not error"
      console.log r
      client.flushdb()
      client.end()
  res.render 'index', { title:"exp" }
