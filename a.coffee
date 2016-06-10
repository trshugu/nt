console.log "aaadesuu", process.argv
console.time "desu"

setTimeout ->
  console.log "hidoukiii"
  console.timeEnd "desu"
  
  if process.send?
    process.send "death", ->
      console.log "seeeeeeeet"
  
, 1000
console.timeEnd "desu"




