express = require "express"
path = require "path"
app = express()

# view engine setup
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

favicon = require "serve-favicon"
# uncomment after placing your favicon in /public
# app.use favicon(__dirname + "/public/favicon.ico")
app.use require("morgan")("dev")
bodyParser = require "body-parser"
app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: false })
app.use require("cookie-parser")()
app.use require("stylus").middleware(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, "public"))

# https対応
app.use (req, res, next) ->
  schema = (req.headers['x-forwarded-proto'] || '').toLowerCase()
  if schema == 'https' || req.secure
    next()
  else
    res.redirect 'https://' + req.headers.host + req.url

# route
routes = require "./routes/index"
users = require "./routes/users"
app.use "/", routes
app.use "/users", users

# cb = require "./routes/cb"
# app.use "/cb", cb.index
# titval = 'Express'
# app.use "/cb", (req, res) -> res.render 'index', { title: titval }
# C = (cb)-> app.use "/cb", cb
# R = require "./routes/cb"
# R.index app, (req, res)-> res.render 'index', { title: titval }
# R.index app,titval
# (require "./routes/cb").index app, (req, res)-> res.render 'index', { title: titval }
# (require "./routes/cb").index app, titval
# コントローラーと従属するビューを定義すべき
# R = require "./routes/cb"
# R.index app, (req, res)-> res.render 'index', { title: titval }
# R.index app, require("./cont")
# R.index app
require("./routes/cb") app




# catch 404 and forward to error handler
app.use (req, res, next)->
  err = new Error "Not Found"
  err.status = 404
  next err

# error handlers

# development error handler
# will print stacktrace
if (app.get "env" == "development")
  app.use (err, req, res, next)-> 
    res.status(err.status || 500)
    res.render "error",
      message: err.message,
      error: err

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next)->
  res.status(err.status || 500)
  res.render "error",
    message: err.message,
    error: {}

module.exports = app
