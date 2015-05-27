module.exports = (app)->
  app.get "/", require "./index"
  app.post "/", require "./index"
  app.get "/user", require "./user"


