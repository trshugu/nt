express = require("express")
router = express.Router()


data = require("../maro")()

# GET home page. 
router.get "/", (req, res) ->
  res.render "index",
    title: "Express"
    data: data

  return

module.exports = router
