messages = [
  { id: 0, message: 'Koa next generation web framework for node.js' },
  { id: 1, message: 'Koa is a new web framework designed by the team behind Express' }
]

views = require('co-views')
render = views(__dirname + '/../views', map: html: 'swig')

module.exports.home = ->
  @body = yield render 'list', 'messages': messages

module.exports.list = ->
  @body = yield messages

module.exports.fetch = (id) ->
  message = messages[id]
  if (!message)
    @throw 404, 'message with id = ' + id + ' was not found'
  
  @body = yield message

parse = require('co-body')
module.exports.create =  ->
  message = yield parse(@)
  message.id = messages.push(message) - 1
  @redirect('/')

# One way to deal with asynchronous call
doSomeAsync = ->
  return (callback) ->
    setTimeout ->
      callback(null, 'this was loaded asynchronously and it took 3 seconds to complete')
    , 3000

module.exports.delay = ->
  @body = yield doSomeAsync()
