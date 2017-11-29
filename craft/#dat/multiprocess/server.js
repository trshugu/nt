var net = require('net');
var http = require('http');
var child_process = require('child_process');

var child = child_process.fork('child.js');
var server = net.createServer();

server.listen(8080, '127.0.0.1', function () {
  child.send('server', server);
  console.log('create parent server...');
  
  var httpServer = http.createServer();
  httpServer.on('request', function (request, response) {
    console.log('processed by parent: ' + request.url);
    response.writeHead(200);
    response.write('processed by parent');
    response.end();
  });
  
  httpServer.listen(server);
});