getDb = (filename) -> new Promise (f,r)->
  require("request").get 
    uri: "https://api-content.dropbox.com/1/files/auto/" + filename
    headers: 
      "Authorization":"Bearer uJAog14rUsMAAAAAAACt1zMx1oRGXUGb2PRi6wbN7PFDbaIYKgBTglI5e9hcPzPo"
      'Content-Type': 'application/octet-stream'
    json: true
  , (e,r,b)->
    if e?
      r e
    else
      f b

getDb("tl.json").then (v)->
  console.log v.map (i)->i.date
