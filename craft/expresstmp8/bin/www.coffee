#!/usr/bin/env coffee
cluster = require "cluster"
https = require "https"
http = require "http"
fs = require "fs"

if cluster.isMaster
  for i in [1..require("os").cpus().length]
    w = cluster.fork()
  
  # I—¹‚ğó‚¯æ‚é
  cluster.on 'exit',(worker, code, signal)->
    console.log worker.process.pid + ' exit:' + worker.id
    cluster.fork()
  
else
  debug = require('debug')('expresstmp8')
  app = require '../app'
  
  ###
  app.set 'port', process.env.PORT || 3000
  
  server = app.listen app.get('port'), ->
    debug 'Express server listening on port ' + server.address().port
  ###
  
  options = 
    key: fs.readFileSync "./bin/key.key"
    cert: fs.readFileSync "./bin/crt.crt"
  
  server = http.createServer(app).listen 80, ->
    debug 'Express server listening on port ' + server.address().port
  
  secserver = https.createServer(options, app).listen 443, ->
    debug 'Express server listening on port ' + secserver.address().port
