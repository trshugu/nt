@echo off
rem set DEBUG=expresstemplate
rem set NODE_ENV=development
set NODE_ENV=production
coffee app.coffee %1
