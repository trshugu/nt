module.exports = (app, controller) ->
  app.get '/' , controller.index.index
  app.get '/rickshaw', controller.graph.rickshaw
  app.get '/flotr', controller.graph.flotr

