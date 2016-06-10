console.log "aaadesuu", process.argv[2]

console.time "desu"
setTimeout ->
  console.log "hidoukiii"
  console.timeEnd "desu"
  
  process.send "death" if process.send?
, 1000
console.timeEnd "desu"

