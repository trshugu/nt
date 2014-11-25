http = require 'http'
url = require 'url'
cp = require("child_process")
cluster = require("cluster")
cpuCount = require("os").cpus().length






if cluster.isMaster
  for i in [1..cpuCount]
    cluster.fork()
  cluster.on 'exit',(worker, code, signal)->
    console.log('worker_id:' + worker.id)
else
  console.log cluster.worker.id
  server = http.createServer()
  server.on "request",(req,res) ->
    # console.log req.url
    # console.log url.parse(req.url)["query"]
    for i in [1..100000000]
      console.log i if i % 10000000 == 0
    res.setHeader 'Content-Type', 'text/plain'
    res.writeHead 200
    res.end 'ok'
    console.log "timeout"
  
  port = ("133" + cluster.worker.id)
  server.listen port, ->
    console.log "port " + port




###
server = http.createServer()
server.on "request",(req,res) ->
  # console.log req.url
  # console.log url.parse(req.url)["query"]
  child = cp.fork("child.coffee")
  child.send "server", server
  for i in [1..100000000]
    i
  res.setHeader 'Content-Type', 'text/plain'
  res.writeHead 200
  res.end 'ok'
  console.log "timeout"

server.listen 1337, ->
  console.log "port 1337"
###



###
if cluster.isMaster
  server = http.createServer()
  server.on "request",(req,res) ->
    cluster.fork()
  server.listen 1337, ->
  console.log "port 1337"
else
  console.log process.env.NODE_UNIQUE_ID
  process.on "message", (res) ->
    
###

###
if cluster.isMaster
  for i in [1..cpuCount]
    cluster.fork().send "amama"
  
  cluster.on 'exit',(worker, code, signal)->
    console.log('worker_id:' + worker.id)
    # console.log('worker_pid:' + worker.process.pid)
    # console.log('code:' + code)
    # console.log('signal:' + signal)
else
  server = http.createServer()
  server.on "request",(req,res) ->
    setTimeout ->
      res.setHeader 'Content-Type', 'text/plain'
      res.writeHead 200
      res.end 'ok'
      console.log "timeout"
    , 5000
  server.listen 1337, ->
  console.log "port 1337"
  
  process.on "message", (server) ->
    console.log "2"
    console.log server
    # server = http.createServer()
    # server.listen 1337, ->
###



###
child = cp.fork("child.coffee")

server = http.createServer()
server.on "request",(req,res) ->
  # console.log req.url
  # console.log url.parse(req.url)["query"]
  setTimeout ->
    res.setHeader 'Content-Type', 'text/plain'
    res.writeHead 200
    res.end 'ok'
    console.log "timeout"
  , 5000

server.listen 1337, ->
  console.log "port 1337"
  for i in [1..cpuCount]
    child.send "server", server
    # w = cluster.fork("child.coffee")
    # w.send "server", server
  
  cluster.on('exit',(worker, code, signal)->
    console.log('worker_id:' + worker.id)
  )
###
