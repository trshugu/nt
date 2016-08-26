module.exports = (render)-> (a,b)->
  dp = {}
  dp.ppp = "spa"
  
  @body = yield render 'spa', dp



