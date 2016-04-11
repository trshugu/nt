module.exports = (app, route, render)->
  app.use route.get '/', require('./index')(render)
  