io = require('socket.io').listen(
  require('http').createServer((req, res)-> 
    res.writeHead(200, {"Content-Type":"text/html"})
    res.end(require('jade').compileFile("./index.jade", "utf-8")())
  ).listen(process.env.VMC_APP_PORT || 3000)
)

io.sockets.on('connection', (soc) ->
  console.log 'con'
  soc.on('mes', (data)->
    console.log data
    io.emit("cast",(data))
    #  soc.broadcast.emit("cast",(data))
  )
)
