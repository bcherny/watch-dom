angular
.module('watchDom', [])
.constant('watchDomOptions', {
	attributes: true,
	characterData: true,
	childList: true
})
.service('watchDom', function ($window, watchDomOptions) {

	this.$watch = function (element, cb, options) {

		if (!angular.isElement(element)) {
			throw new TypeError('watchDom expects its 1st argument to be a DOMElement, but was given ', element);
		}

		if (!angular.isFunction(cb)) {
			throw new TypeError('watchDom expects its 2nd argument to be a Function, but was given ', cb);
		}

		var mutationObserver = new $window.MutationObserver(function (mutationRecord) {
			cb(mutationRecord, mutationRecord.oldValue);
		});

		mutationObserver.observe(
			element,
			angular.extend({}, watchDomOptions, options)
		);

		return mutationObserver.disconnect.bind(mutationObserver);

	};

});