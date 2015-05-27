module.exports = (req, res)->
  console.log "top"
  res.render 'top', { title:"exp" }