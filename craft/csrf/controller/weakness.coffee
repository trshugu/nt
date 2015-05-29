module.exports = (req, res)->
  console.log req.query
  console.log req.body
  console.log req.session
  console.log req.params
  
  console.log req.headers
  # console.log req._parsedUrl
  
  console.log "headerのクッキー"
  console.log req.headers.cookie
  
  disp = {}
  disp.title = "weakness"
  # disp.csrf = req.csrfToken()

  if req.method == "POST"
    console.log "post!!!!"
    if req.session?
      console.log "sessionに投入"
      req.session.noir = req.body.intext
      console.log req.session
    
    res.render 'weakness', disp
  else
    res.render 'weakness', disp



