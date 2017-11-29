module.exports = (render)-> ->
  dp = {}
  dp.data = "nakami"
  
  @body = yield dp

