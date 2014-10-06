@s = io.connect('localhost');
s.on('cast', (data)->
  console.log("cast")
  $('#tmp').append("<div>" + data + "</div>")
)
