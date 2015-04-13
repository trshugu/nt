module.exports = (req, res)->
  console.log "m_member"
  res.render 'm_member', { title:"exp" }
  