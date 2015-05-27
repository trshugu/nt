module.exports = (req, res)->
  console.log "rend index"
  res.render 'index', { title:"exp" }

