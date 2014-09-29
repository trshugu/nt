express = require('express')
path = require('path')
router = express.Router();
app = express()

app.set('views', path.join(__dirname, 'views'))
app.set("view engine", 'jade')

app.get('/', (req, res)->
  res.render('index', { title: 'tete'})
)

app.listen(3000)
