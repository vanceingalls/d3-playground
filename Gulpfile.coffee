gulp = require 'gulp'
coffee = require 'gulp-coffee'
watch = require 'gulp-watch'
plumber = require 'gulp-plumber'
sourcemaps = require 'gulp-sourcemaps'
sass = require 'gulp-sass'
wiredep = require('wiredep').stream
webserver = require('gulp-webserver')

distDir = '.'
coffeeSrc = 'src/*.coffee'
sassSrc = 'src/*.sass'

gulp.task 'coffee', ->
  gulp.src coffeeSrc
      .pipe plumber()
      .pipe(sourcemaps.init())
      .pipe coffee(bare: true)
      .pipe(sourcemaps.write(distDir))
      .pipe gulp.dest(distDir)

gulp.task 'sass', ->
  gulp.src(sassSrc)
    .pipe plumber()
    .pipe(sass().on('error', sass.logError))
    .pipe gulp.dest(distDir)

gulp.task 'watch', ->
  watch coffeeSrc, ->
    gulp.start 'coffee'
  watch sassSrc, ->
    gulp.start 'sass'

gulp.task 'bower', ->
  gulp.src('./index.html')
    .pipe wiredep()
    .pipe gulp.dest('.')

gulp.task 'webserver', ->
  gulp.src('.')
    .pipe webserver(
      livereload:
        enable: true
        filter: (fileName) ->
          fileName.match(/script|style|index/)
      open: true
      path: '/')

gulp.task 'default', ['bower','webserver', 'coffee', 'sass', 'watch']
