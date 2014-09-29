check_uri = require("./checklinkmodule")
# console.log check_uri("http://yahoo.co.jp")

a = check_uri("http://yahoo.co.jp")
a.on('response',(res)->
  console.log res.statusCode
)

# console.log a
