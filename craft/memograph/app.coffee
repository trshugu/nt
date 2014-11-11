express = require("express")
app = express()

# view engine setup
path = require("path")
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

# use coffeescript
app.use require('coffee-middleware')(
  src: path.join(__dirname, "/public")
  compress: true
  bare: true
)

# use stylus
app.use require("stylus").middleware(path.join(__dirname, "public"))

logger = require("morgan")
app.use logger("dev")

bodyParser = require("body-parser")
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)

cookieParser = require("cookie-parser")
app.use cookieParser()

app.use express.static(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, "bower_components"))

# routes
app.use "/", require("./routes/index")
app.use "/users", require("./routes/users")
app.use "/flotr", require("./routes/flotr")

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

module.exports = app
