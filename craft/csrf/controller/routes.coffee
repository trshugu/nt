module.exports = (app)->
  app.get "/weakness", require "./weakness"
  app.post "/weakness", require "./weakness"
  
  app.get "/", require "./index"
  app.get "/user", require "./user"


