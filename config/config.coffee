path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
	development:
		root: rootPath
		app:
			name: 'sneaquence'
		port: 3000
		db: 'mongodb://localhost/sneaquence-development'

	test:
		root: rootPath
		app:
			name: 'sneaquence'
		port: 3000
		db: 'mongodb://localhost/sneaquence-test'

	production:
		root: rootPath
		app:
			name: 'sneaquence'
		port: 3000
		db: 'mongodb://localhost/sneaquence-production'

module.exports = config[env]
