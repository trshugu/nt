module.exports = (app)->
  app.get "/crypt", require "./crypt"
  app.get "/api/:crypt", require "./api"
  app.get "/", require "./index"
  app.get "/user", require "./user"


