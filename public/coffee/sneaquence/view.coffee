Vue = require 'vue/dist/vue'

module.exports = class View
	constructor: (el, data) ->
		Vue.config.debug = true
		window.vm = new Vue(
			el: el
			data: data
		)
