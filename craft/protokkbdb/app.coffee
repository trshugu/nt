debug = require("debug")("expresstemplate")
express = require "express"
path = require "path"
favicon = require "serve-favicon"
logger = require "morgan"
cookieParser = require "cookie-parser"
bodyParser = require "body-parser"
http = require 'http'

app = express()

# view engine setup
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

# uncomment after placing your favicon in /public
# app.use(favicon(__dirname + '/public/favicon.ico'));
app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use express.static(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, 'bower_components'))

# use coffeescript
app.use require('coffee-middleware')
  src: path.join(__dirname, "public")
  compress: true
  bare: true

# use stylus
app.use require('stylus').middleware(path.join(__dirname, 'public'))

# routes
app.get '/', (req, res)-> res.render 'index'
app.get '/tricklelist', (req, res)-> res.render 'tricklelist'
app.get '/links', (req, res)-> res.render 'links'

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
io = require('socket.io').listen(server)
server.listen app.get('port'), ->
  debug "Express server listening on portee " + server.address().port


# ==============================================================================
fs  = require "fs"

Date2String = (d)->
  d.getFullYear() + "/" \
   + ("0" + (d.getMonth() + 1)).slice(-2) + "/" \
   + ("0" + d.getDate()).slice(-2)

io.sockets.on 'connection', (soc) ->
  # tléÊìæÇµÇƒï\é¶
  soc.on "trickle_disp", ->
    tl = JSON.parse(fs.readFileSync "tl.json", "utf-8")
    io.emit "trickle_disp_res", tl
  
  # tléÊìæÇµÇƒí«â¡
  soc.on "trickle_add", (
    kin,
    ki,
    kai,
    yo,
    shi,
    ri,
    me,
    ami,
    ju,
    date)->
    tl = JSON.parse(fs.readFileSync "tl.json", "utf-8").filter (i)-> i.date != Date2String(new Date())
    
    tl.unshift {
        "kin":kin
        "ki":ki
        "kai":kai,
        "yo":yo
        "shi":shi,
        "ri":ri
        "me":me
        "ami":ami
        "ju":ju
        "date":date
      }
    
    fs.writeFileSync "tl.json", JSON.stringify(tl)
    
    # ï\é¶éwé¶
    io.emit "trickle_redesp"




