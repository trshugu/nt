express = require("express")
router = express.Router()

index = (serie) ->
  router.get "/", (req, res) ->
    res.render "index",
      title: "Express"
      serie: serie
    return

# data formatting
require("../Extract")(index)

module.exports = router
