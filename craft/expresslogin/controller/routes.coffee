login = require "./login"
module.exports = (app)->
  app.get "/", login, require("./index")
  app.get "/user", require "./user"


