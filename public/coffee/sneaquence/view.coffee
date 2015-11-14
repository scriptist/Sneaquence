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
			setTimeout =>
				@render 0
			, 100

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
			time = @posToTime e.pageX
			this.set time
			@render time

		onMouseUp: (e) ->
			document.body.style.cursor = null
			window.removeEventListener 'mousemove', @onMouseMove
			window.removeEventListener 'mouseup', @onMouseUp

		posToTime: (pos) ->
			if !@parentWidth
				return 0

			proportion = (pos - @el.offsetWidth / 2) / (@parentWidth - @el.offsetWidth)
			proportion = Math.min(Math.max(proportion, 0), 1)
			time = proportion * this.params.duration
			return time

		timeToPos: (time) ->
			if !@parentWidth
				return @el.offsetWidth / 2

			pos = time / this.params.duration * (@parentWidth - @el.offsetWidth) + @el.offsetWidth / 2
			return pos

		render: (time) ->
			pos = @timeToPos time

			@el.style.left = pos + 'px'
	}
}
