module.exports = (req, res)->
  console.log "member"
  res.render 'member', { title:"exp" }
  