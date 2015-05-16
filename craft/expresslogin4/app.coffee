debug = require("debug")("expresstemplate")
cluster = require "cluster"

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
  # config = require "config"
  # console.log "env:" + process.env.NODE_ENV
  # console.log config
  # console.log config.ccc
  # console.log config.def
  # console.log config.hoka
  
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
  # uncomment after placing your favicon in /public
  # app.use(favicon(__dirname + '/public/favicon.ico'));
  app.use require("morgan")("dev")
  # app.use require("morgan")("common")
  
  # f = require('fluent-logger-node')
  # l = f.createLogger({tagPrefix:"tag.express"})
  # mor = require("morgan") "tiny", stream: f
  # app.use require("morgan")("tiny", {stream: l.stream})
  # app.use (req, res, next) ->
  #   mor req, res, (e)->
  #     next()
  
  ###
  f = require('fluent-logger-node')
  l = f.createLogger({tagPrefix:"tag.express"})
  app.use (req, res, next) ->
    sock = req.socket
    remoteAddress = if sock.socket then sock.socket.remoteAddress else sock.remoteAddress
    method = req.method
    url = req.url
    httpVersion = req.httpVersion
    startTime = Date.now()
    
    logRequest = ->
      res.removeListener('finish', logRequest)
      res.removeListener('close', logRequest)
      
      len = parseInt(res.getHeader('Content-Length'), 10)
      
      l.post 'tag.hell',
        'remote-address': remoteAddress
        'method': method
        'url': url
        'http-version': httpVersion
        'status': res.statusCode
        'res[content-length]': if isNaN(len) then '' else len
        'response-time': Date.now() - startTime
    
    res.on('finish', logRequest)
    res.on('close', logRequest)
    
    next();
  ###
  
  # rotatingLogStream = require('file-stream-rotator').getStream({filename:"test.log", frequency:"1m", verbose: false});
  # app.use require("morgan") "tiny", stream: rotatingLogStream
  
  app.use require("morgan") "tiny", stream: require('fs').createWriteStream(__dirname + '/log.txt', { flags: 'a' })
  
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
  
  # fluent
  ###
  fluent = require 'fluent-logger-node'
  fl = fluent.createLogger()
  fl.on "flu", (i)->
    fl.post "tag.coffee", {coffeen:"post" + i.toString()}
  ###
  
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
  
  ###
  app.set 'port', process.env.PORT || 3000
  server = http.createServer(app)
  server.listen app.get('port'), ->
    debug "Express server listening on portee " + server.address().port
  ###
  
  options = 
    key: fs.readFileSync "./key.key"
    cert: fs.readFileSync "./crt.crt"
  
  server = http.createServer(app).listen 80, ->
    debug 'Express server listening on port ' + server.address().port
  # io = require('socket.io').listen(3000)
  io = require('socket.io').listen(server)
  
  
  redis=require "redis"
  rs = require "socket.io-redis"
  io.adapter rs(
    host: "localhost"
    port: 6379
    )
  
  require("./controller/socapi") io
  
  ###
  secserver = https.createServer(options, app).listen 443, ->
    debug 'Express server listening on port ' + secserver.address().port
  iossl = require('socket.io').listen(secserver)
  
  require("./controller/socapi") iossl
  
  server_api = http.createServer(app).listen 8080, ->
    debug 'Express server listening on port ' + server_api.address().port
  ###
  
  ###
  io.sockets.on 'connection', (soc)->
    soc.on "sock", (d)->
      console.log d
  ###

