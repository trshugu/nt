###
express = require 'express'
router = express.Router()

router.get '/', (req, res)->
  res.render 'index', { title: 'Express' }


module.exports = router
###
# exports.index = (req, res)-> res.render 'index', { title: 'Express' }
# exports.index = (app, titval)-> app.get "/cb", (req, res)-> res.render 'index', { title: titval }
# exports.index = (app, titval)-> app.get "/cb", (req, res)-> res.render 'index', { title: titval }
# exports.index = (app, cb)-> app.get "/cb", cb

# メソッド、パス、コントローラーへの紐づけを持つべき
# .get "/path", controller
# exports.index = (app, cont)-> app.get "/cb", cont
# exports.index = (app)-> app.get "/cb", require("../cont")
module.exports = (app)->
  app.get "/cb", require("../cont")
  app.get "/cb2", require("../cont")