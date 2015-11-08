module.exports = class Welcome
	constructor: (@api, @data, @done) ->
		@data.welcome =
			sequences: null
			newSequenceName: null
			loadSequenceId: null
			newSequence: @newSequence
			loadSequence: @loadSequence
			checkLoadValidity: @checkLoadValidity

		@api.get '/sequences', (res) =>
			@data.welcome.sequences = res.sequences
			@data.loading   = false

	checkLoadValidity: (e) =>
		if !@data.welcome.newSequenceName
			e.preventDefault()

	newSequence: (e) =>
		if !e.target.files || !e.target.files.length
			return

		@data.loading = true
		reader = new FileReader
		reader.onload = (e) =>
			sequence = {
				name: @data.welcome.newSequenceName
				music: reader.result
			}

			@api.post '/sequences', sequence, (res) =>
				@data.loading = false

				if res.error
					alert res.message
				else
					@data.sequence = res.sequence
					@data.sequence.music = sequence.music
					typeof @done == 'function' && @done()

		reader.readAsDataURL e.target.files[0]

	loadSequence: (e) =>
		if typeof e == 'string'
			id = e
		else
			id = @data.welcome.loadSequenceId
			e.preventDefault()

		@data.loading = true
		@api.get "/sequences/#{id}", (res) =>
			@data.loading = false

			if res.error
				alert res.message
			else
				@data.sequence = res.sequence
				typeof @done == 'function' && @done()
