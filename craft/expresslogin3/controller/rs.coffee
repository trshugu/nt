module.exports = (req, res)->
  console.log req.query
  console.log req.body
  console.log req.session
  console.log req.params
  
  # req.session.noi = "noi_session"
  
  res.render 'rs'
  
  

