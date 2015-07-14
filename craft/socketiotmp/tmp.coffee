io = require('socket.io').listen(
  require('http').createServer (req, res)-> 
    res.writeHead 200, "Content-Type":"text/html"
    res.end require('jade').compileFile("./index.jade")()
  .listen(process.env.VMC_APP_PORT || 3000)
)

io.sockets.on 'connection', (soc) ->
  console.log 'con'
  soc.on 'ioemit', (data) -> io.emit "cast",(data)
  soc.on 'broadcast', (data) -> soc.broadcast.emit "cast",(data)
  soc.on 'socemit', (data) -> soc.emit "cast",(data)
  
  io.emit "cnt", soc.client.conn.server.clientsCount
  
  soc.on "disconnect", (d)->
    console.log d
    io.emit "cnt", soc.client.conn.server.clientsCount

