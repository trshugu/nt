module.exports = (app, route, render)->
  # app.use route.get '/', require('./index')(render)
  app.use route.get '/data', require('./data')(render)
  app.use route.get '/error', require('./error')(render)
  app.use route.get '/nf', require('./nf')(render)
  app.use route.post '/poster', require('./poster')(render)
  app.use route.get '/rnd/:id', require('./rnd')(render)
  app.use route.get '/para/:pa/:ra', require('./para')(render)
  
  app.use route.get '*index.html', require('./redirect')(render)

  