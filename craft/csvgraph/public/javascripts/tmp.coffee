@rick = (arr = []) ->
  serie = arr
  graph = new Rickshaw.Graph(
    element: document.querySelector("#chart")
    width: 300
    height: 200
    renderer: 'bar'
    stack: false
    series: [{
      color: "steelblue"
      name: " "
      data: serie
    }]
  )
  
  hoverDetail = new Rickshaw.Graph.HoverDetail(
    graph: graph
    xFormatter: (x) -> return x + " hour"
    yFormatter: (y) -> return y + " count"
  )
  
  axesx = new Rickshaw.Graph.Axis.X(
    graph: graph,
    tickFormat: (a)->
      a
  )
  
  axes = new Rickshaw.Graph.Axis.Y(
    graph: graph,
    tickFormat: (a)->
      a
  )
  
  graph.render()
