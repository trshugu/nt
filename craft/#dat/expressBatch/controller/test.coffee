module.exports = (req, res)->
  # endを返し終了する
  
  res.end "end"
  process.exit()
  # res.render 'index', title:"exp"
  
  