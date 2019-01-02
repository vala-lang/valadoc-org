/**
 * gulpfile.babel.js
 * Builds local assets for production environment
 */

import gulp from 'gulp'

import imagemin from 'gulp-imagemin'

import postcss from 'gulp-postcss'
import postcssPresetEnv from 'postcss-preset-env'

import babel from 'gulp-babel'

// All browsers we should _try_ to build for
const browsers = ['last 4 version', 'not ie <= 11']

/**
 * images
 * Compresses images for production
 *
 * @return {Task} - a gulp task
 */
gulp.task('images', () => {
  const base = 'data/images'
  const src = ['data/images/*']
  const dest = 'valadoc.org/images'

  return gulp.src(src, { base })
    .pipe(imagemin())
    .pipe(gulp.dest(dest))
})

/**
 * scripts
 * Copies scripts to production folder
 *
 * @return {Task} - a gulp task
 */
gulp.task('scripts', gulp.parallel(
  function valadoc() {
    const base = 'data/scripts'
    const src = ['data/scripts/*.js']
    const dest = 'valadoc.org/scripts'

    return gulp.src(src, { base })
      .pipe(babel({
        presets: [
          [
            '@babel/preset-env',
            {
              "targets": browsers
            }
          ]
        ]
      }))
      .pipe(gulp.dest(dest))
  },
  function fetchPolyfill() { // fetch polyfill
    const base = 'node_modules/whatwg-fetch'
    const src = ['node_modules/whatwg-fetch/*.js']
    const dest = 'valadoc.org/scripts'

    return gulp.src(src, { base })
      .pipe(gulp.dest(dest))
  }
))

/**
 * styles
 * Builds and compresses styles for production use
 *
 * @return {Task} - a gulp task
 */
gulp.task('styles', () => {
  const base = 'data/styles'
  const src = ['data/styles/*.css']
  const dest = 'valadoc.org/styles'

  return gulp.src(src, { base })
    .pipe(postcss([
      postcssPresetEnv({ browsers })
    ]))
    .pipe(gulp.dest(dest))
})

/**
 * php
 * Copies over php files to production folder
 *
 * @return {Task} - a gulp task
 */
gulp.task('php', () => {
  const base = 'data'
  const src = ['data/**/*.php']
  const dest = 'valadoc.org'

  return gulp.src(src, { base })
    .pipe(gulp.dest(dest))
})

/**
 * default
 * Runs all needed files for production environment
 *
 * @return {Task} - a gulp task
 */
gulp.task('default', gulp.parallel('images', 'scripts', 'styles', 'php'))
