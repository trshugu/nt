http = require("http")

process.on "message", (msg, server) ->
  if msg is "server"
    console.log "create child server..."
    
    httpServer = http.createServer()
    httpServer.on "request", (request, response) ->
      console.log "processed by child: " + request.url
      response.writeHead 200
      response.write "processed by child"
      response.end()
      return
    
    httpServer.listen server
  return

