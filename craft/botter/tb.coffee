bot = require "./bot/bothelper"


console.log "1"
if(tweet?)
  console.log "2"
  client = bot.twiauth()
  val = bot.GetRandomOneline("list.txt")
  client.post('statuses/update', {status: val},  (error, tweet, response)->
    throw error if(error)
    # console.log(tweet)
    # console.log(response)
  )

console.log "3"

client = bot.twiauth()
# client.get("statuses/home_timeline",(e,t,r)->
#   t.map((t)->console.log t.created_at)
# )

params = screen_name: "sage_HDxxx"
client.get('statuses/user_timeline', params, (e,t,r)->
  t.map((t)-> console.log t.text.replace(/^@\w+?\s/g,"").replace(/\s/g,""))
)

