module.exports = (app)->
  app.get "/", require "./index"
  app.get "/user", require "./user"
  
  app.get "/ddl", require "./ddl"
  app.post "/ddl", require "./ddl"


