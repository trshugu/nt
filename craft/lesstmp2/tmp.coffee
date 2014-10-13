require('socket.io').listen(
  require('http').createServer((req, res)-> 
    res.writeHead(200, {"Content-Type":"text/html"})
    res.end(require('jade').compileFile("./index.jade", "utf-8")())
  ).listen(process.env.VMC_APP_PORT || 3000)
)