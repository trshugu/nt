module.exports = (app)->
  app.get "/", require "./index"
  app.get "/get", require "./get"
  app.get "/user", require "./user"


