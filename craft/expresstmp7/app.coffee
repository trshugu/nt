require('coffee-script/register')
debug = require('debug')('expresstmp')
express = require("express")
path = require("path")
favicon = require("serve-favicon")
logger = require("morgan")
cookieParser = require("cookie-parser")
bodyParser = require("body-parser")
app = express()

# view engine setup
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

# uncomment after placing your favicon in /public
app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use express.static(path.join(__dirname, "public"))

app.get '/', (req, res) ->
  res.render('index', { title: 'kani' })


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

app.set('port', process.env.PORT || 3000)

server = app.listen(app.get('port'), ->
  debug('Express server listening on port ' + server.address().port)
)
