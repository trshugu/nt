net = require("net")
http = require("http")
child_process = require("child_process")

child = child_process.fork("child.coffee")

server = net.createServer()
server.listen 8080, "127.0.0.1", ->
  child.send "server", server
  console.log "create parent server..."
  httpServer = http.createServer()
  httpServer.on "request", (request, response) ->
    console.log "processed by parent: " + request.url
    response.writeHead 200
    response.write "processed by parent"
    response.end()
    return

  httpServer.listen server
  return

