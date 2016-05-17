module.exports = (render, messages)-> ->
  dp = {}
  dp.ppp = "nakami"
  
  @body = yield render 'index', dp

