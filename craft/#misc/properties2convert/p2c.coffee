require("fs").readFile process.argv[2],encoding:"utf-8",(e,d)->
  d.match(/(\\u[\w\d]{4})/g).forEach((utf)-> d = d.replace utf, require("punycode").ucs2.encode( [parseInt(utf.slice(2), 16)] )) if d.match(/(\\u[\w\d]{4})/g)?
  console.log(d)
