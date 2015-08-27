@echo off
set DEBUG=expresstemplate
set NODE_ENV=development
rem set NODE_ENV=production
coffee app.coffee %1
