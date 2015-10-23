@rick = (arr = []) ->
  
  serie = [
    {
      data: arr
      # label: "ラベル"
    }
  ]
  
  Flotr.draw(
    document.getElementById("graph")
    serie
    mouse: 
      track: true
    xaxis:
      ticks:
        for i in [0..23]
          [i,i]
    # legend:
      # labelFormatter: (label) -> label
      # backgroundColor: "#D2E8FF"
    # title: "tititi"
    HtmlText: false
  )
  
