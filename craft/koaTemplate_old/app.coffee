koa = require('koa')
route = require 'koa-route'
serve = require 'koa-static'
views = require 'co-views'
app = koa()

# jadeをテンプレートエンジンとして設定。
render = views(__dirname + '/views', { map : {html : 'jade'}})

# GET /views => render template engine
app.use route.get('/views', (next)->
  # bodyに対してindex.jadeの変更を実施。
  this.body = yield render('index.jade', {name: "koa"})
)

# GET /hello => 'Hello!'
app.use route.get('/hello', (next)=>
  this.body = 'Hello!!'
)

# GET /hello/:name => 'Hello :name'
app.use route.get('/hello/:name', (name) ->
  this.body = 'Hello ' + name;
)

# static file serve
app.use serve(__dirname + '/public')

app.listen(3000); 

###
app.use *->
  this.body = "noi"
  console.log "non"

# http.createServer(app.callback()).listen(3000)
app.listen 3000
###


###
debug = require("debug")("expresstemplate2")
express = require "koa"
path = require "path"
http = require 'http'

# 予期せぬエラーをキャッチし停止させないようにする
process.on 'uncaughtException', (e) ->
  console.log e

app = express()

# view engine setup
app.use "views", -> path.join(__dirname, "views")
app.use "view engine", "jade"

favicon = require "serve-favicon"
# uncomment after placing your favicon in /public
# app.use(favicon(__dirname + '/public/favicon.ico'));
app.use require("morgan")("dev")
bodyParser = require "body-parser"
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use require("cookie-parser")()
app.use express.static(path.join(__dirname, "public"))

# use coffeescript
app.use require('iced-coffee-middleware')
  src: path.join(__dirname, "public")
  compress: true
  bare: true

# use stylus
app.use require('stylus').middleware(path.join(__dirname, 'public'))

# ここにhttps対応
# app.use (req, res, next) ->
#   schema = (req.headers['x-forwarded-proto'] || '').toLowerCase()
#   if schema == 'https' || req.secure
#     next()
#   else
#     res.redirect 'https://' + req.headers.host + req.url

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
###

