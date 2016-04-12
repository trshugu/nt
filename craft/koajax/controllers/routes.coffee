module.exports = (app, route, render)->
  app.use route.get '/', require('./index')(render)
  app.use route.get '/data', require('./data')(render)
  app.use route.get '/error', require('./error')(render)
  app.use route.get '/nf', require('./nf')(render)
  app.use route.post '/poster', require('./poster')(render)
  