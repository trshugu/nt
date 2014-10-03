# render jade
http = require('http')
jade = require('jade')

server = http.createServer((req, res)-> 
  res.writeHead(200, {"Content-Type":"text/html"})
  res.end(jade.compileFile("./index.jade", "utf-8")())
).listen(process.env.VMC_APP_PORT || 3000)

socketio = require('socket.io')
io = socketio.listen(server)
io.sockets.on('connection', (soc) ->
  console.log 'con'
  soc.on('mes', (data)->
    console.log data
    io.emit("cast",(data))
  )
)


