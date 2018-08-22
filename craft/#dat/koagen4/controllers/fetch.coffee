module.exports = (render, messages)-> (id)->
  message = messages[id]
  if (!message)
    @throw 404, 'message with id = ' + id + ' was not found'
  
  @body = yield message
