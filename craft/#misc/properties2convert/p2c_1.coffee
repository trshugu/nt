require("fs").readFile process.argv[2],encoding:"utf-8",(e,d)->
  for i in d.split("\n")
    line = i
    utfs = i.match(/(\\u[\w\d]{4})/g)
    if utfs?
      utfs.forEach (utf)->
        line = line.replace utf, require("punycode").ucs2.encode( [parseInt(utf.slice(2), 16)] )
    
    require("fs").appendFileSync process.argv[2] + ".txt", line
