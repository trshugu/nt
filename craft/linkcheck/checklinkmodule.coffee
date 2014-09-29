url = require('url')


# URIチェック
check_uri = (uri) ->
  try
    parsed_uri = url.parse(uri)
    
    http = null
    switch parsed_uri.protocol
      when 'http:'
        http = require('http')
      when 'https:'
        http = require('https')
      else
        throw("not url")
    
    console.log("get")
    return http.get(uri,(res)->
      res.on('end',(res)->
        console.log("check")
        if res.statusCode == 301 || res.statusCode == 302
          console.log("redirect")
          return uri + " " + res.statusCode + "\n"
        else if res.statusCode == 200
          console.log("OK")
          return null
        else
          console.log("notfound")
          return uri + " " + res.statusCode + "\n"
      )
      
    )
    
    console.log("getend")
  catch e
    console.log e
    return uri + ' 例外\n'
  


module.exports = check_uri