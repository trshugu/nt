module.exports = (req, res)->
  console.log "rend form"
  console.log res
  res.render 'form', { title:"exp", word: res.body.word }

