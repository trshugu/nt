@echo off
rem coffee -c tmp.coffee && ^
rem node tmp.js
rem coffee test.coffee %1
mocha --compilers coffee:coffee-script/register test.coffee
rem mocha -w --reporter dot --compilers coffee:coffee-script/register test.coffee
rem mocha --compilers coffee:coffee-script/register
