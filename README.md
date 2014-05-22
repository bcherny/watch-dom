watch-dom
=========

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

## alternative approaches

- model observers ([`$watch`](https://docs.angularjs.org/api/ng/type/$rootScope.Scope#$watch))
- pub/sub emitters ([`$emit`](https://docs.angularjs.org/api/ng/type/$rootScope.Scope#$emit), [`$broadcast`](https://docs.angularjs.org/api/ng/type/$rootScope.Scope#$broadcast))

## read

- [w3 spec](https://dvcs.w3.org/hg/domcore/raw-file/tip/Overview.html#mutation-observers)
- [mdn doc](https://developer.mozilla.org/en-US/docs/Web/API/MutationObserver)