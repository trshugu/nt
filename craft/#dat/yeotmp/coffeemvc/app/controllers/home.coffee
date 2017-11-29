express  = require 'express'
router = express.Router()

module.exports = (app) ->
  app.use '/', router

articles = "death"

router.get '/', (req, res, next) ->
    res.render 'index',
      title: 'Generator-Express MVC'
      articles: articles
