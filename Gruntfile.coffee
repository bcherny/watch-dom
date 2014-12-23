module.exports = (grunt) ->

	[
		'grunt-contrib-coffee'
		'grunt-contrib-jasmine'
		'grunt-contrib-watch'
		'grunt-coveralls'
		'grunt-ngmin'
	]
	.forEach grunt.loadNpmTasks

	# task sets
	build = ['ngmin']
	test = ['coffee:test', 'jasmine:unit']
	coverage = ['coffee:test', 'jasmine:coverage']

	# task defs
	grunt.initConfig

		pkg: grunt.file.readJSON 'package.json'

		coffee:
			test:
				files:
					'test/test.js': 'test/test.coffee'
				options:
					bare: true
					sourceMap: true

		coveralls:
			options:
				force: true
			main:
				src: 'reports/lcov/lcov.info'

		jasmine:
			coverage:
				src: [
					'./src/<%= pkg.name %>.js'
				]
				options:
					specs: ['./test/test.js']
					template: require 'grunt-template-jasmine-istanbul'
					templateOptions:
						coverage: 'reports/lcov/lcov.json'
						report: [
							{
								type: 'html'
								options:
									dir: 'reports/html'
							}
							{
								type: 'lcov'
								options:
									dir: 'reports/lcov'
							}
						]
					type: 'lcovonly'
					vendor: [
						'./bower_components/angular/angular.js'
						'./bower_components/angular-mocks/angular-mocks.js'
					]
			unit:
				src: './src/<%= pkg.name %>.js'
				options:
					specs: './test/test.js'
					vendor: [
						'./bower_components/angular/angular.js'
						'./bower_components/angular-mocks/angular-mocks.js'
					]
					keepRunner: true

		ngmin:
			main:
				src: ['./src/<%= pkg.name %>.js']
				dest: './dist/<%= pkg.name %>.js'

		watch:
			main:
				files: './src/*'
				tasks: build
				options:
					interrupt: true
					spawn: false
			test:
				files: './test/*.coffee'
				tasks: coverage
				options:
					interrupt: true
					spawn: false

	grunt.registerTask 'default', build
	grunt.registerTask 'test', test
	grunt.registerTask 'coverage', coverage