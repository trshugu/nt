var http = require('http');

process.on('message', function (msg, server) {
  if (msg === 'server')
  {
    console.log('create child server...');
    
    var httpServer = http.createServer();
    httpServer.on('request', function (request, response) {
      console.log('processed by child: ' + request.url);
      response.writeHead(200);
      response.write('processed by child');
      response.end();
    });
    
    httpServer.listen(server);
  }
});
