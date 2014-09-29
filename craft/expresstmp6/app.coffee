express = require('express')
app = express()
engines = require('consolidate')

# app.engine('slim', engines.slim);

app.get('/', (req, res)->
  res.send('Hell World')
)

app.listen(3000)

