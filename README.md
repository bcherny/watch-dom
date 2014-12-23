# watch-dom [![Build Status][build]](https://travis-ci.org/bcherny/watch-dom) [![Coverage Status][coverage]](https://coveralls.io/r/bcherny/watch-dom) ![][bower] [![npm]](https://www.npmjs.com/package/watch-dom)

[build]: https://img.shields.io/travis/bcherny/watch-dom.svg?branch=master&style=flat-square
[coverage]: http://img.shields.io/coveralls/bcherny/watch-dom.svg?branch=master&style=flat-square
[bower]: https://img.shields.io/bower/v/watch-dom.svg?style=flat-square
[npm]: https://img.shields.io/npm/v/watch-dom.svg?style=flat-square

## what?

efficiently watch for changes to a dom element (or its descendents).

## why?

angular `$watch` observes property modifications on the `$scope`, since in angular the `$scope` is the source of truth. this is a good pattern for most use cases. however, there are situations where you want modules to be decoupled, and the dom is the fundamental source of truth.

## how?

**default config**

```js
watchDom.$watch(DOMElement, function (newValue, oldValue) {
	...
});
```

**watch custom properties ([like what?](https://developer.mozilla.org/en-US/docs/Web/API/MutationObserver#MutationObserverInit))**

```js
var props = {
	subtree: true,
	attributeFilter: ['foo', 'bar']
};

watchDom.$watch(DOMElement, function (newValue, oldValue) {
	...
}, props);
```

## full example

```html
<myDirective>
	<myOtherDirective>
	</myOtherDirective>
</myDirective>
```

```js
angular
.module('myModule', ['watchDom'])
.directive('myDirective', function (watchDom) {

	return {
		link: function (scope, element) {

			var otherDirective = element.find('myOtherDirective');

			watchDom.$watch(otherDirective, function() {

				// do something

			});

		}
	};
	
});
```

## browser compatibility

ie11+, firefox 28+, chrome 31+, safari 7+, opera 20+, ios 6+, android 4.4+

[full list](http://caniuse.com/#feat=mutationobserver)

## alternative approaches

- model observers ([`$watch`](https://docs.angularjs.org/api/ng/type/$rootScope.Scope#$watch))
- pub/sub emitters ([`$emit`](https://docs.angularjs.org/api/ng/type/$rootScope.Scope#$emit), [`$broadcast`](https://docs.angularjs.org/api/ng/type/$rootScope.Scope#$broadcast))

## read

- [w3 spec](https://dvcs.w3.org/hg/domcore/raw-file/tip/Overview.html#mutation-observers)
- [mdn doc](https://developer.mozilla.org/en-US/docs/Web/API/MutationObserver)