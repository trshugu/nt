path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'coffeemvc'
    port: 3000

  test:
    root: rootPath
    app:
      name: 'coffeemvc'
    port: 3000

  production:
    root: rootPath
    app:
      name: 'coffeemvc'
    port: 3000

module.exports = config[env]
