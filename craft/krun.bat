@echo off
rem coffee -c tmp.coffee && ^
rem node tmp.js
rem set NODE_ENV=production
coffee --nodejs --harmony tmp.coffee %1 %2 %3 %4 %5 %6

