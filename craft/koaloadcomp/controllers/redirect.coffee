module.exports = (render, messages)-> ->
  console.log "redirect!"
  @.redirect "/"
  yield []
  ###
  dp = {}
  dp.ppp = "nakami"
  
  @body = yield render 'index', dp
  ###
