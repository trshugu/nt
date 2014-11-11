router = require("express").Router()

# data formatting
require("../extract") (daily) ->
  serie = []
  for i in [0..23]
    serie.push("[" + i + ", " + daily[i] + "]")  
  
  router.get "/", (req, res) ->
    res.render "flotr",
      title: "Express"
      serie: "[" + serie.join() + "]"
    return

module.exports = router
