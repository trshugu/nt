module.exports = (render, messages)-> ->
  @body = yield render 'list.jade', 'messages': messages

