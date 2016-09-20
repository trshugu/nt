module.exports = (render)-> ->
  console.log "kiteru"
  dp = {}
  dp.data = "nakami"
  
  console.log @query
  console.log @req.method
  if @req.method == "POST"
    param = yield require('co-body')(@)
    console.log param
  
  
  @body = yield render 'sub', dp
  # @body = yield require('co-body')(@)
  # @header = yield []
  
  # console.log @

