express = require('express')
app = express()

app.get('/', (req, res)-> 
  res.send('Hell, express')
)

app.listen(3000)
