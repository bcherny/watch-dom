// Generated by CoffeeScript 1.7.1
describe('watch-dom', function() {
  var $window, MutationObserver, methods;
  methods = {
    observe: function(element, options) {
      this.element = element;
      this.options = options;
      return this.fn;
    },
    disconnect: function() {},
    fire: this.fn
  };
  MutationObserver = (function() {
    function MutationObserver(fn) {
      this.fn = fn;
      this.observe = methods.observe;
      this.disconnect = methods.disconnect;
      this.fire = methods.fire;
    }

    return MutationObserver;

  })();
  $window = {
    MutationObserver: MutationObserver
  };
  beforeEach(module('watchDom', function($provide) {
    $provide.value('$window', $window);
    return null;
  }));
  beforeEach(function() {
    return inject(function($document, watchDom) {
      this.$document = $document;
      this.watchDom = watchDom;
    });
  });
  return describe('watchDom', function() {
    it('should have a #$watch method', function() {
      return expect(angular.isFunction(this.watchDom.$watch)).toBe(true);
    });
    it('should throw a TypeError when passed a non-element as a 1st argument', function() {
      return expect(function() {
        return this.watchDom.$watch(42);
      });
    });
    it('should throw a TypeError when passed a non-function as a 2nd argument', function() {
      return expect(function() {
        return this.watchDom.$watch(this.$document, 42);
      }).toThrowError(TypeError);
    });
    it('should instantiate a MutationObserver', function() {
      spyOn($window, 'MutationObserver').and.callThrough();
      this.watchDom.$watch(this.$document, function() {});
      return expect($window.MutationObserver).toHaveBeenCalled();
    });
    it('should call instance#observe with the element and options', inject(function(watchDomOptions) {
      spyOn(methods, 'observe');
      this.watchDom.$watch(this.$document, function() {});
      return expect(methods.observe.calls.argsFor(0)).toEqual([this.$document, watchDomOptions]);
    }));
    it('should extend its default options with the passed options', inject(function(watchDomOptions) {
      var options;
      options = {
        foo: 'bar',
        baz: 'moo',
        attributes: false
      };
      spyOn(methods, 'observe');
      this.watchDom.$watch(this.$document, (function() {}), options);
      return expect(methods.observe.calls.argsFor(0)).toEqual([this.$document, angular.extend(watchDomOptions, options)]);
    }));
    return it('should return instance#disconnect', function() {
      var disconnect;
      disconnect = this.watchDom.$watch(this.$document, function() {});
      return expect(disconnect).toBe(methods.disconnect);
    });
  });
});