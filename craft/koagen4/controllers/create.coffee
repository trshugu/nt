parse = require('co-body')
module.exports = (render, messages)-> ->
  message = yield parse(@)
  console.log message
  message.id = messages.push(message) - 1
  @redirect('/')

