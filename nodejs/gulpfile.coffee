gulp = require 'gulp'
plugins = require('gulp-load-plugins')()
source = require 'vinyl-source-stream'
browserify = require 'browserify'
watchify = require 'watchify'


gulp.task 'server', ->
   plugins.developServer.listen path:'./app/server.coffee', plugins.livereload.listen

gulp.task 'browserify', ->
    bundler = browserify
      entries: ['./app/browser.coffee']
      extensions: ['.coffee', '.js']
      debug: true
      cache: {}, packageCache: {}
    bundler.transform 'coffee-reactify'

    watcher  = watchify bundler
    watcher
    .on 'update', ->
        updateStart = Date.now()
        watcher
        .bundle().on 'error', plugins.util.log
        .pipe source 'bundle.js'
        .pipe gulp.dest './app/public/js/'
        plugins.util.log 'Done browserifying'
    .bundle()
    .pipe source 'bundle.js'
    .pipe gulp.dest './app/public/js/'


gulp.task 'default',['server', 'browserify'], ->
  sources = [ './app/*.coffee', './app/*.cjsx']
  reloadServer = (file) ->
    plugins.util.log 'Server restarted'
    plugins.developServer.restart (error) ->
        if !error then plugins.livereload.changed file.path
  gulp.watch sources
    .on 'change', reloadServer
