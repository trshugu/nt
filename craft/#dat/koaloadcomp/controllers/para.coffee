module.exports = (render)-> (a,b)->
  console.log @req.param
  console.log a
  console.log b
  @body = yield []



