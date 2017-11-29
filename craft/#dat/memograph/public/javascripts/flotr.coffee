@rick = (arr = []) ->
  data = arr
  
  serie = [
    {
      data: data
      label: "ラベル"
    }
  ]
  
  Flotr.draw(
    document.getElementById("graph")
    serie
    bars:
      show:true
    mouse: 
      track: true
    xaxis:
      ticks:
        for i in [0..23]
          [i,i]
    legend:
      position: "se"
      labelFormatter: (label) -> label
      backgroundColor: "#D2E8FF"
    title: "tititi"
    HtmlText: false
  )
  
