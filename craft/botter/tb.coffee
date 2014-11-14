
twiauth = require "./bot/twiauth"
client = twiauth()

client.updateStatus "death",(d)->
