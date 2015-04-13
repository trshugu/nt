module.exports = (req, res)->
  console.log "rend formpost"
  console.log req.body
  res.cookie "kukki", "nanigasi"
  res.render 'form', { title:"exp", word: req.body.word }

