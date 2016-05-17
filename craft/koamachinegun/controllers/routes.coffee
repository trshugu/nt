module.exports = (app, route, render)->
  app.use route.get '/', require('./index')(render)
  app.use route.get '/fire/:url/:cnt', require('./fire')(render)
  