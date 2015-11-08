baseURL = '/api'

module.exports = class Api
	get: (path, callback) ->
		# Add cachebreaker
		t = (new Date).getTime()
		if path.indexOf('?') == -1
			path += "?t=#{t}"
		else
			path += "&t=#{t}"

		sendRequest 'GET', path, null, callback

	post: (path, data, callback) ->
		sendRequest 'POST', path, data, callback

	put: (path, data, callback) ->
		sendRequest 'PUT', path, data, callback

	delete: (path, data, callback) ->
		sendRequest 'DELETE', path, data, callback

sendRequest = (method, path, data, callback) ->
	url = "#{baseURL}#{path}"

	xhr = new XMLHttpRequest()

	xhr.open method, url, true
	xhr.withCredentials = true

	xhr.addEventListener 'load', onLoad.bind xhr, path, callback

	if method != 'GET'
		xhr.setRequestHeader 'Content-Type', 'application/json; charset=UTF-8'
		xhr.send JSON.stringify data
	else
		xhr.send()

onLoad = (path, callback, e) ->
	try
		response = this.response
		response = JSON.parse response
	catch
		throw new Error "Invalid response received from #{path}."

	if typeof callback == 'function'
		callback response
