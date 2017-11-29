cluster = require "cluster"

if cluster.isMaster
  if process.argv[2]?
    console.log "multi core"
    cpu_count = require("os").cpus().length
  else
    console.log "single core"
    cpu_count = 1
  
  for i in [0...cpu_count]
    w = cluster.fork()
    console.log  "fork:" + w.process.pid
  
  # 終了を受け取って再起動する
  cluster.on 'exit',(worker, code, signal)->
    console.log  worker.process.pid + ' exit:' + worker.id
    cluster.fork()
else
  io = require('socket.io').listen(
    require('http').createServer (req, res)-> 
      res.writeHead 200, "Content-Type":"text/html"
      res.end require('jade').compileFile("./index.jade")()
    .listen(process.env.VMC_APP_PORT || 3000)
  )
  
  io.set "transports",["websocket", "polling"]
  
  if process.argv[2]?
    console.log "use redis"
    redisStore = require "socket.io-redis"
    io.adapter redisStore()
  

  io.sockets.on 'connection', (soc) ->
    console.log 'con'
    soc.on 'ioemit', (data) -> io.emit "cast",(data)
    soc.on 'broadcast', (data) -> soc.broadcast.emit "cast",(data)
    soc.on 'socemit', (data) -> soc.emit "cast",(data)
    
    io.emit "cnt", soc.client.conn.server.clientsCount
    
    soc.on "disconnect", (d)->
      console.log d
      io.emit "cnt", soc.client.conn.server.clientsCount

