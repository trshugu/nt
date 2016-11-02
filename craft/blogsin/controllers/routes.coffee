module.exports = (app, route, render)->
  app.use route.get '/', require('./index')(render)
  app.use route.post '/', require('./index')(render)
  