winston = require 'winston'
logger = new (winston.Logger)(
  transports: [
    new (winston.transports.File)(
      level: 'info',
      timestamp: true,
      filename: 'log.txt',
      json: false
    )
  ]
)

module.exports = (name)->
  logger.info(name)