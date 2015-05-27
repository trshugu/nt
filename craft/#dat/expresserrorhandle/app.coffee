debug = require("debug")("expresstemplate")
cluster = require "cluster"

# 予期せぬエラーをキャッチし停止させないようにする
process.on 'uncaughtException', (e) ->
  console.log e

if cluster.isMaster
  cpu_count = 1
  if(process.env.DEBUG)
    cpu_count = 1
  else
    cpu_count = require("os").cpus().length
  
  for i in [1..cpu_count]
    w = cluster.fork()
    debug "fork:" + w.process.pid
  
  # 終了を受け取って再起動する
  cluster.on 'exit',(worker, code, signal)->
    debug  worker.process.pid + ' exit:' + worker.id
    cluster.fork()
  
else
  express = require "express"
  path = require "path"
  http = require 'http'
  https = require "https"
  fs = require "fs"
  session = require "express-session"
  
  app = express()
  if(process.env.DEBUG)
    console.log "debug!!!"
    RedisStore = require("connect-redis")(session)
    app.use session
      key: "sess_id"
      cookie:
        maxAge: 1000 * 60 * 60
      resave: false
      saveUninitialized: true
      secret: "sekret"
  else
    console.log "productio"
    RedisStore = require("connect-redis")(session)
    app.use session
      key: "sess_id"
      cookie:
        maxAge: 1000 * 60 * 60
      store: new RedisStore
        db: 1
        prefix: "session"
      resave: false
      saveUninitialized: true
      secret: "sekret"
  
  
  # view engine setup
  app.set "views", path.join(__dirname, "views")
  app.set "view engine", "jade"
  
  favicon = require "serve-favicon"
  app.use require("morgan")("dev")
  
  bodyParser = require "body-parser"
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(extended: false)
  app.use require("cookie-parser")()
  app.use express.static(path.join(__dirname, "public"))
  app.use express.static(path.join(__dirname, 'bower_components'))
  app.use express.static(path.join(__dirname, 'sound'))
  
  # use coffeescript
  app.use require('coffee-middleware')
    src: path.join(__dirname, "public")
    compress: true
    bare: true
  
  # use stylus
  app.use require('stylus').middleware(path.join(__dirname, 'public'))
  
  # ここにhttps対応
  
  # routes
  require("./controller/routes") app
  
  # catch 404 and forward to error handler
  app.use (req, res, next) ->
    err = new Error("Not Found")
    err.status = 404
    next err
    return
  
  
  # error handlers
  
  # development error handler
  # will print stacktrace
  if app.get("env") is "development"
    app.use (err, req, res, next) ->
      # fl.emit 'flu', err
      res.status err.status or 500
      res.render "error",
        message: err.message
        error: err
      return
  
  
  # production error handler
  # no stacktraces leaked to user
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render "error",
      message: err.message
      error: {}
  
    return
  
  options = 
    key: fs.readFileSync "./key.key"
    cert: fs.readFileSync "./crt.crt"
  
  server = http.createServer(app).listen 80, ->
    debug 'Express server listening on port ' + server.address().port
  # io = require('socket.io').listen(3000)
  io = require('socket.io').listen(server)
  
  if(!process.env.DEBUG)
    redis=require "redis"
    rs = require "socket.io-redis"
    io.adapter rs(
      host: "localhost"
      port: 6379
      )
  
  
  require("./controller/socapi") io

