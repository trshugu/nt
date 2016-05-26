views = require('co-views')
parse = require('co-body')
messages = [
  { id: 0, message: 'Koa next generation web framework for node.js' },
  { id: 1, message: 'Koa is a new web framework designed by the team behind Express' }
]

render = views(__dirname + '/../views', {
  map: { html: 'swig' }
})

module.exports.home = ->
  this.body = yield render('list', { 'messages': messages })


module.exports.list = ->
  this.body = yield messages


module.exports.fetch = (id) ->
  message = messages[id]
  if (!message)
    this.throw(404, 'message with id = ' + id + ' was not found')
  
  this.body = yield message


module.exports.create =  ->
  message = yield parse(this)
  id = messages.push(message) - 1
  message.id = id
  this.redirect('/')


doSomeAsync = ->
  return (callback) ->
    setTimeout ->
      callback(null, 'this was loaded asynchronously and it took 3 seconds to complete')
    , 3000
 

# One way to deal with asynchronous call
module.exports.delay = ->
  this.body = yield doSomeAsync()
