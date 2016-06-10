module.exports = (app)->
  app.get "/", require "./index"
  app.get "/user", require "./user"
  app.get "/test", require "./test"
  app.get "/batch", require "./batch"


