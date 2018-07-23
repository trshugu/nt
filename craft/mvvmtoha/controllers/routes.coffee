route = require('koa-route')
module.exports = (app)->
  app.use route.get '/', require('./index')
  
  app.use route.get '/step3', require('./step3')
  app.use route.get '/api', require('./api')
  
  app.use route.get '/step1', require('./step1')
 