module.exports = (req, res)->
  console.log req.query
  console.log req.body
  console.log req.session
  console.log req.params
  
  res.render 'foll', {a_sid: "startsisi"}
  
  

