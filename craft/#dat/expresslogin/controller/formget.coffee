module.exports = (req, res)->
  console.log "rend formget"
  console.log req.cookies
  console.log req.session
  console.log req.session.user
  res.render 'form', { title:"exp"}

