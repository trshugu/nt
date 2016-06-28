module.exports = (render)-> ->
  dp = {}
  dp.data = "nakami"
  
  console.log @query
  # param = yield require('co-body')(@)
  # console.log param.parame
  
  
  @body = yield require('co-body')(@)
  # @header = yield []
  
  # console.log @

