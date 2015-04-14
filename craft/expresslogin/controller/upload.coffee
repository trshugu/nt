fs = require "fs"
module.exports = (req, res)->
  console.log "uplloooaaddd!!!"
  req.session.nanka = "gyosyou"
  console.log req.query
  console.log req.body
  
  console.log req.files
  console.log req.files.fiile
  console.log req.files.fiile.path
  tmp_path = req.files.fiile.path
  console.log tmp_path
  target_path = './uploads/' + req.files.fiile.originalname;
  console.log target_path
  fs.rename tmp_path, target_path, (e)->
    console.log e if e
    fs.unlink tmp_path, ->
      res.send('File uploaded to: ' + target_path + ' - ' + req.files.fiile.size + ' bytes')
      # res.redirect '/user'
  
  
  
  