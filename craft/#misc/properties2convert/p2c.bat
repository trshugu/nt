@echo off
rem coffee -e "$_.scan(/(\\u[\w\d]{4})/).each{|utf|$_.sub!(utf[0],(utf[0][2,4]).to_i(16).chr('UTF-8'))}" %1 >> %1.txt
coffee "C:\gh\nt\craft\properties2convert\p2c.coffee" %1 >> %1.txt
