module.exports = class Welcome
	constructor: (@api, @data) ->
		@data.welcome =
			sequences: null
			newSequenceName: null
			loadSequenceId: null
			newSequence: @onNewSequenceSubmit
			loadSequence: @onLoadSequenceSubmit

		@api.get '/sequences', (res) =>
			@data.welcome.sequences = res.sequences
			@data.loading   = false


	onNewSequenceSubmit: (e) =>
		e.preventDefault()
		alert 'new'

	onLoadSequenceSubmit: (e) =>
		e.preventDefault()
		alert 'load'
