module.exports = (req, res)->
  console.log "m_top"
  res.render 'm_top', { title:"exp" }