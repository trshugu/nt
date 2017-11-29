module.exports = (app)->
  
  # app.get "/ssi", (req,res)->
  #   res.send require("fs").readFileSync("./public/ssinclu.html", "utf-8")
  
  app.get "/", require "./index"
  app.get "/user", require "./user"


