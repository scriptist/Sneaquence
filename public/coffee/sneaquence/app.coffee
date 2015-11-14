Api     = require './api'
Player  = require './player'
View    = require './view'
Welcome = require './welcome'

module.exports = class Sneaquence
	constructor: (@el) ->
		@data = {
			loading: true
			sequence: null
			player: null
			cursor: 10
		}

		window.data = @data

		@api     = new Api
		@player  = new Player @data
		@welcome = new Welcome @api, @data

		# Init view last
		@view    = new View @el, @data, @methods

		@view.vm.$watch 'sequence', (val) =>
			if val && !@data.player.loaded && !@data.player.loading
				@player.load()

		@welcome.loadSequence '56471186857f029417011eb7'
