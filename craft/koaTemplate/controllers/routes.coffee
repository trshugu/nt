route = require('koa-route')
module.exports = (app)->
  app.use route.get '/:msg', require('./index')
 