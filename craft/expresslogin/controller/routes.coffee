login = require "./login"
mlogin = require "./m_login"
module.exports = (app)->
  app.get "/", login, require("./index")
  app.get "/user", require "./user"
  app.get "/form", require "./formget"
  app.post "/form", require "./formpost"
  
  app.get "/normal", require "./normal"
  app.get "/logined", login, require("./logined")
  app.post "/logined", login, require("./logined")
  
  app.get "/loginform", require "./loginform"
  
  app.get "/m_member", mlogin, require("./m_member")
  app.get "/m_login", mlogin
  app.post "/m_login", mlogin
  app.get "/m_top", require "./m_top"
  

