http = require("http")

console.log "child"

process.on "message", (msg, server) ->
  if msg is "server"
    console.log "create child server..."
    
    httpServer = http.createServer()
    httpServer.on "request", (req, res) ->
      for i in [1..100000000]
        console.log i if i % 10000000 == 0
      res.setHeader 'Content-Type', 'text/plain'
      res.writeHead 200
      res.end 'child ok'
      console.log "child timeout"
    
    httpServer.listen server
  return

