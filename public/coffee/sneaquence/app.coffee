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
			cursor: 0
			debug: {
				visible: false
				toggle: =>
					@data.debug.visible = !@data.debug.visible
			}
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

		@view.vm.$watch 'player.loaded', (val) =>
			if val
				@data.sequence.music = null
				delete @data.sequence.music

		window.addEventListener 'keyup', (e) =>
			if e.keyCode == 192 # `
				@data.debug.toggle()

		@welcome.loadSequence '56471186857f029417011eb7'
