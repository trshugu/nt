express = require("express")
router = express.Router()

index = (serie) ->
  router.get "/", (req, res) ->
    res.render "flotr",
      title: "Express"
      serie: serie
    return

# data formatting
require("../flotr")(index)

module.exports = router
