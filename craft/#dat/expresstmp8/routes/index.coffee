express = require 'express'
router = express.Router()

router.get '/', (req, res)->
  console.log req.secure
  console.log req.headers['x-forwarded-proto']
  res.render 'index', { title: 'Express' }


module.exports = router
