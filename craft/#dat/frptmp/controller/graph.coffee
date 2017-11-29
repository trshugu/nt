exports.rickshaw = (req, res) ->
  require("./extract") (daily)->
    serie = []
    for i in [0..23]
      serie.push("{x:" + i + ", y:" + daily[i] + "}")
    
    res.render "rickshaw",
      title: "Express"
      serie: "[" + serie.join() + "]"



exports.flotr = (req, res) ->
  require("./extract") (daily)->
    serie = []
    for i in [0..23]
      serie.push("[" + i + ", " + daily[i] + "]")  
    
    res.render "flotr",
      title: "Express"
      serie: "[" + serie.join() + "]"



