debug = require("debug")("expresstemplate")
express = require "express"
path = require "path"
http = require 'http'

app = express()

# view engine setup
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

favicon = require "serve-favicon"
# uncomment after placing your favicon in /public
# app.use(favicon(__dirname + '/public/favicon.ico'));
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

ssi = require "ssi"
parser = new ssi()
app.use (req, res, next)->
  console.log "1"
  filename  = __dirname + "/public" + req.path + ".html"
  console.log filename
  if(require("fs").existsSync(filename))
    console.log "2"
    res.send(parser.parse(filename, require("fs").readFileSync(filename, {encoding: "utf8"})).contents)
  else
    console.log "3"
    next()
console.log "4"


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


