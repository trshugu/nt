module.exports = (app)->
  app.get "/sio", require "./sio"
  
  app.get "/", require "./index"
  app.get "/user", require "./user"


