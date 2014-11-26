@echo off
rem coffee -c tmp.coffee && ^
rem node tmp.js
rem coffee test.coffee %1
rem mocha --compilers coffee:coffee-script/register test.coffee
mocha --reporter nyan --compilers coffee:coffee-script/register nyan.coffee
