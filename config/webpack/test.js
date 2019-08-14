const environment = require('./environment')

// process.env.NODE_ENV = process.env.NODE_ENV || 'development'
environment.plugins.get('Manifest').options.writeToFileEmit = process.env.NODE_ENV !== 'test'

const config = environment.toWebpackConfig()
config.devtool = 'inline-source-map'

module.exports = environment.toWebpackConfig()
