Api     = require './api'
View    = require './view'
Welcome = require './welcome'

module.exports = class Sneaquence
	constructor: (@el) ->
		@data = {
			loading: true
			state: 'welcome'
		}

		@api     = new Api
		@welcome = new Welcome @api, @data

		# Init view last
		@view    = new View @el, @data, @methods
