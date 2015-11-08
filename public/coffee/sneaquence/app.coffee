Api     = require './api'
Player  = require './player'
View    = require './view'
Welcome = require './welcome'

module.exports = class Sneaquence
	constructor: (@el) ->
		@data = {
			loading: true
			sequence: null
		}

		@api     = new Api
		@player  = new Player @data
		@welcome = new Welcome @api, @data, =>
			@player.load()


		# Init view last
		@view    = new View @el, @data, @methods

		# @welcome.loadSequence '563f74573b5cb5501940464f'
