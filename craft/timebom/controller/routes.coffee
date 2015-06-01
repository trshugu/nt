module.exports = (app)->
  app.get "/timebom", require "./timebom"

  app.get "/", require "./index"
  app.get "/user", require "./user"


