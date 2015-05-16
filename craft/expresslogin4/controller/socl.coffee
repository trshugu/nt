module.exports =  (req, res)->
  param = {}
  param.list = [1,3,2,5,7]
  res.render 'socl', param

