module.exports = (req, res)->
  console.log req.session
  
  # req.session.don = "k"
  
  res.render 'index', { title:"exp" }