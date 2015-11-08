module.exports = class Player
	constructor: (@data) ->
		@data.player =
			loading: true
			play: @play

	load: =>
		arr = dataURIToBinary @data.sequence.music
		@context = new AudioContext
		@context.decodeAudioData arr.buffer, (buffer) =>
			@buffer = buffer
			@data.player.loading = false

	play: =>
		if @data.player.loading
			return false

		source = @context.createBufferSource()
		source.buffer = @buffer
		source.connect @context.destination
		source.start()



BASE64_MARKER = ';base64,'
dataURIToBinary = (dataURI) ->
	base64Index = dataURI.indexOf(BASE64_MARKER) + BASE64_MARKER.length
	base64 = dataURI.substring(base64Index)
	raw = window.atob(base64)
	rawLength = raw.length
	array = new Uint8Array(new ArrayBuffer(rawLength))
	i = 0
	while i < rawLength
		array[i] = raw.charCodeAt(i)
		i++
	array
