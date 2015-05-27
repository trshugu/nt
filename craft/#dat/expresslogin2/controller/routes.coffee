logincheck = require "./logincheck"

module.exports = (app)->
  app.get "/", require("./index")
  app.get "/member", logincheck, require("./member")
  app.get "/login", require "./login"
  app.post "/login", require "./login"
  app.get "/top", require "./top"
  

