module.exports = (app)->
  app.get "/", require "./index"
  app.get "/user", require "./user"


