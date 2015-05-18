httpscheck = require "./https"

module.exports = (app)->
  app.get "/audio", (req,res)->res.render "audio"
  app.get "/socl", require "./socl"
  
  
  app.get "/rs",  (req,res)-> res.render "rs"
  app.get "/common", (req,res)-> res.render "common", {header:"hedddoooo"}
  
  app.get "/select", (req,res)-> 
    param = {}
    param.sele = "nini"
    res.render "select", param
  
  app.get "/debounce", (req,res)-> res.render "debounce"
  app.get "/image", (req,res)-> res.render "image"
  
  app.get "/videojs", (req,res)->res.render "videojs"
  app.get "/player", (req,res)->res.render "player"
  
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
  
  app.get "/vali", require "./vali"
  app.post "/vali", require "./vali"
  
  app.get "/follow", require "./follow"
  # app.get "/follow", require "./follow"
  
  app.get "/api", (req,res)-> res.send "ok"
  
  app.get "/socket", require "./socket"
  app.get "/socketssl", httpscheck, require "./socket"
  
  app.get "/foll", require "./foll"
  
  app.get "/api", require "./api"
  app.get "/apiget", require "./apiget"
  
  app.get "/upload", require "./upload"
  
  app.get "/socjson", require "./socjson"
  
