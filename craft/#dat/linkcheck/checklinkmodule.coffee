url = require('url')
fs = require('fs')

# ファイル名の渡し方が微妙
# 再帰に対応できない
resultfile = "zzresult_" + process.argv[2]

# URIチェック
check_uri = (uri,callback) ->
  setTimeout (->
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
      
      t = http.get(uri,(res)->)
      
      t.on('response',(res)->
        console.log uri
        if res.statusCode == 301 || res.statusCode == 302
          console.log("redirect")
          # console.log uri + " " + res.statusCode + "\n"
          # console.log res.headers["location"] + "\n"
          fs.appendFile(resultfile , uri  + ' ' + res.statusCode + '\n' )
        else if res.statusCode == 200
          # console.log("OK")
          # console.log uri
        else
          console.log("notfound")
          # console.log uri  + " " + res.statusCode + "\n"
          fs.appendFile(resultfile , uri  + ' ' + res.statusCode + '\n' )
      )
      
      t.on('error',(err)->
        # console.log err
      )
      
    catch e
      # console.log e
      # return uri + ' 例外\n'
    

    callback(null, null)
  ), 0


module.exports = check_uri