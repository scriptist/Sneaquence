Vue = require 'vue/dist/vue'

module.exports = class View
	constructor: (el, data) ->
		window.vm = new Vue(
			el: el
			data: data
		)
