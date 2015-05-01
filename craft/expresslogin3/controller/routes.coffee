module.exports = (app)->
  app.get "/", require "./index"
  app.get "/user", require "./user"
  
  app.get "/ddl", require "./ddl"
  app.post "/ddl", require "./ddl"
  
  app.get "/xf", (req,res)->
    val = req.query.xf
    res.render 'xf',
      xf: require("xss-filters").inHTMLData(val)

  app.get "/nonxf", (req,res)->
    val = req.query.xf
    res.render 'xf',
      xf: val
  
  
  

