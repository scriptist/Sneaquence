Api  = require './api'
View = require './view'

module.exports = class Sneaquence
	constructor: (@el) ->
		@data = {
			loading: true
			state: 'welcome'
			welcome:
				sequences: null
				newSequenceName: null
				loadSequenceId: null
				newSequence: @createNewSequence
				loadSequence: @loadSequence
		}

		@api = new Api
		@view = new View @el, @data, @methods

		@api.get '/sequences', (res) =>
			@data.welcome.sequences = res.sequences
			@data.loading   = false

	createNewSequence: ->


	loadSequence: ->
		alert 123
