messages = [
  { id: 0, message: 'Koa next generation web framework for node.js' },
  { id: 1, message: 'Koa is a new web framework designed by the team behind Express' }
]

module.exports = (app, route, render)->
  app.use route.get '/', require('./home')(render, messages)
  app.use route.get '/messages', require('./list')(render, messages)
  app.use route.get '/messages/:id', require('./fetch')(render, messages)
  app.use route.post '/messages', require('./create')(render, messages)
  app.use route.get '/async', require('./delay')(render, messages)
  app.use route.get '/recaptcha', require('./recaptcha')(render, messages)
  app.use route.post '/recaptcha', require('./recaptcha')(render, messages)
  