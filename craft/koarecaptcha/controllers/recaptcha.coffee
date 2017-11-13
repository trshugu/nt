module.exports = (render, messages)-> ->
  if @req.method == "POST"
    console.log "is post"
    console.log @req.body
  
  @body = yield render 'recaptcha.jade', 'messages': messages

