Vue = require 'vue/dist/vue'

module.exports = class View
	constructor: (el, data) ->
		@registerComponents()
		@registerDirectives()

		@vm = new Vue(
			el: el
			data: data
		)

	registerComponents: ->
		for component in components
			Vue.component component.tag, component.constructor

	registerDirectives: ->
		for directive in directives
			Vue.directive directive.id, directive.definition


components = []

directives = []
directives.push {
	id: 'cursor'
	definition: {
		deep: true
		twoWay: true
		params: ['duration']
		bind: ->
			@onMouseDown = @onMouseDown.bind @
			@onMouseMove = @onMouseMove.bind @
			@onMouseUp   = @onMouseUp  .bind @

			@el.addEventListener 'mousedown', @onMouseDown

		update: (newValue, oldValue) ->
			@render newValue

		unbind: ->
			@onMouseUp()
			@el.removeEventListener 'mousedown', @onMouseDown

		onMouseDown: (e) ->
			@parentWidth = @el.parentElement.offsetWidth

			document.body.style.cursor = 'ew-resize'
			window.addEventListener 'mousemove', @onMouseMove
			window.addEventListener 'mouseup', @onMouseUp

			@onMouseMove e

		onMouseMove: (e) ->
			proportion = e.pageX / @parentWidth
			proportion = Math.min(Math.max(proportion, 0), 1)
			time = proportion * this.params.duration
			this.set time
			@render time

		onMouseUp: (e) ->
			document.body.style.cursor = null
			window.removeEventListener 'mousemove', @onMouseMove
			window.removeEventListener 'mouseup', @onMouseUp

		render: (time) ->
			@el.style.left = time / this.params.duration * 100 + '%'
	}
}
