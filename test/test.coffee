describe 'watch-dom', ->

	methods =
		observe: (@element, @options) -> @fn
		disconnect: ->
		fire: @fn

	class MutationObserver
		constructor: (@fn) ->
			@observe = methods.observe
			@disconnect = methods.disconnect
			@fire = methods.fire

	$window =
		MutationObserver: MutationObserver

	beforeEach module 'watchDom', ($provide) ->
		
		$provide.value '$window', $window

		null

	beforeEach ->
		
		inject (@$document, @watchDom) ->


	#########################################


	describe 'watchDom', ->

		it 'should have a #$watch method', ->

			expect angular.isFunction @watchDom.$watch
			.toBe true

		it 'should throw a TypeError when passed a non-element as a 1st argument', ->

			expect -> @watchDom.$watch 42

		it 'should throw a TypeError when passed a non-function as a 2nd argument', ->

			expect -> @watchDom.$watch @$document, 42
			.toThrowError TypeError

		it 'should instantiate a MutationObserver', ->

			spyOn $window, 'MutationObserver'
			.and.callThrough()

			@watchDom.$watch @$document, ->

			do expect $window.MutationObserver
			.toHaveBeenCalled

		it 'should call instance#observe with the element and options', inject (watchDomOptions) ->

			spyOn methods, 'observe'

			@watchDom.$watch @$document, ->

			expect methods.observe.calls.argsFor 0
			.toEqual [@$document, watchDomOptions]

		it 'should extend its default options with the passed options', inject (watchDomOptions) ->

			options =
				foo: 'bar'
				baz: 'moo'
				attributes: false

			spyOn methods, 'observe'

			@watchDom.$watch @$document, (->), options

			expect methods.observe.calls.argsFor 0
			.toEqual [@$document, angular.extend watchDomOptions, options]

		it 'should return a function', ->

			expect angular.isFunction @watchDom.$watch @$document, ->
			.toBe true