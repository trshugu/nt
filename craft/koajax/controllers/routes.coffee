module.exports = (app, route, render)->
  app.use route.get '/', require('./index')(render)
  app.use route.get '/data', require('./data')(render)
  app.use route.get '/error', require('./error')(render)
  app.use route.get '/nf', require('./nf')(render)
  app.use route.post '/poster', require('./poster')(render)
  app.use route.get '/rnd/:id', require('./rnd')(render)
  app.use route.get '/para/:pa/:ra', require('./para')(render)
  
  app.use route.get '/spa', require('./spa')(render)
  app.use route.get '/spadata', require('./spadata')(render)
  
  app.use route.get '/sub', require('./sub')(render)
  app.use route.post '/sub', require('./sub')(render)
  app.use route.get '/sh', require('./sh')(render)
  app.use route.get '/dataset', require('./dataset')(render)
  