debug = require("debug")("expresstemplate")
cluster = require "cluster"

if cluster.isMaster
  if(process.env.DEBUG)
    cpu_count = 1
  else
    cpu_count = require("os").cpus().length
  
  for i in [0...cpu_count]
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

  app = express()
  
  # session redisstore
  session = require "express-session"
  if(app.get("env") is "development")
    console.log "debug!!!"
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

  # use coffeescript
  app.use require('coffee-middleware')
    src: path.join(__dirname, "public")
    compress: true
    bare: true

  # use stylus
  app.use require('stylus').middleware(path.join(__dirname, 'public'))

  ###
  # ここにhttps対応
  app.use (req, res, next) ->
    schema = (req.headers['x-forwarded-proto'] || '').toLowerCase()
    if schema == 'https' || req.secure
      next()
    else
      res.redirect 'https://' + req.headers.host + req.url
  ###
  
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

  app.set 'port', process.env.PORT || 3000
  server = http.createServer(app)
  # io = require('socket.io').listen(server)
  server.listen app.get('port'), ->
    debug "Express server listening on portee " + server.address().port


