app = module.exports = require('koa')()

# Logger
app.use require('koa-logger')()

# route
route = require('koa-route')

messages = require('./controllers/messages')

app.use route.get('/', messages.home)
app.use route.get('/messages', messages.list)
app.use route.get('/messages/:id', messages.fetch)
app.use route.post('/messages', messages.create)
app.use route.get('/async', messages.delay)

# Serve static files
app.use require('koa-static')(require('path').join(__dirname, 'public'))

# Compress
app.use require('koa-compress')()

if !module.parent
  app.listen 3000
  console.log 'listening on port 3000'
