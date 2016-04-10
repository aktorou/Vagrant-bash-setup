'use strict';

import plugins  from 'gulp-load-plugins';
import yargs    from 'yargs';
import browser  from 'browser-sync';
import gulp     from 'gulp';
import panini   from 'panini';
import rimraf   from 'rimraf';
import sherpa   from 'style-sherpa';
import yaml     from 'js-yaml';
import fs       from 'fs';
require('es6-promise').polyfill();

// Load all Gulp plugins into one variable
const $ = plugins();

// Check for --production flag
const PRODUCTION = !!(yargs.argv.production);

// Load settings from settings.yml
const { COMPATIBILITY, PORT, UNCSS_OPTIONS, PATHS } = loadConfig();

function loadConfig() {
  let ymlFile = fs.readFileSync('config.yml', 'utf8');
  return yaml.load(ymlFile);
}

// Build the "dist" folder by running all of the below tasks
gulp.task('build',
 gulp.series(clean, gulp.parallel(htaccess, setupIndex, pages, sass, javascript, images, copy)));

// Build the site, run the server, and watch for file changes
gulp.task('default',
  gulp.series('build', server, watch));



gulp.slurped = false; // step 1


// gulp.task("default", ["some-task", "another-task", "watch"]);

// Delete the "dist" folder
// This happens every time a build starts
function clean(done) {
  rimraf(PATHS.dist, done);
}

// Copy files out of the assets folder
// This task skips over the "img", "js", and "scss" folders, which are parsed separately
function copy() {
  return gulp.src(PATHS.assets)
    .pipe(gulp.dest(PATHS.dist + '/public/assets'));
}

// Copy page templates into finished HTML files
function pages(done) {
  gulp.src('src/app/**/*')
  .pipe(gulp.dest(PATHS.dist + '/app'));
  done();
}

function htaccess(done){
  gulp.src('src/**/.htaccess')
  .pipe(gulp.dest(PATHS.dist));
  done();
}

function setupIndex(done){
  gulp.src('src/public/index.php')
  .pipe(gulp.dest(PATHS.dist + '/public'));
  done();
}

// Compile Sass into CSS
// In production, the CSS is compressed
function sass() {
  return gulp.src('src/public/assets/scss/app.scss')
    .pipe($.sourcemaps.init())
    .pipe($.sass({
      includePaths: PATHS.sass
    })
      .on('error', $.sass.logError))
    .pipe($.autoprefixer({
      browsers: COMPATIBILITY
    }))
    .pipe($.if(PRODUCTION, $.uncss(UNCSS_OPTIONS)))
    .pipe($.if(PRODUCTION, $.cssnano()))
    .pipe($.if(!PRODUCTION, $.sourcemaps.write()))
    .pipe(gulp.dest(PATHS.dist + '/public/assets/css'))
    .pipe(browser.reload({ stream: true }));
}

// Combine JavaScript into one file
// In production, the file is minified
function javascript() {
  return gulp.src(PATHS.javascript)
    .pipe($.sourcemaps.init())
    .pipe($.babel())
    .pipe($.concat('app.js'))
    .pipe($.if(PRODUCTION, $.uglify()
      .on('error', e => { console.log(e); })
    ))
    .pipe($.if(!PRODUCTION, $.sourcemaps.write()))
    .pipe(gulp.dest(PATHS.dist + '/public/assets/js'));
}

// Copy images to the "dist" folder
// In production, the images are compressed
function images() {
  return gulp.src('src/public/assets/img/**/*')
    .pipe($.if(PRODUCTION, $.imagemin({
      progressive: true
    })))
    .pipe(gulp.dest(PATHS.dist + '/public/assets/img'));
}

// Start a server with BrowserSync to preview the site in
function server(done) {
  // browser.init({
  //   server: PATHS.dist
  // });
  done();
}


// Watch for changes to static assets, pages, Sass, and JavaScript
function watch() {
  // gulp.watch('../gulpfile.babel.js', gulp.build);

  if(!gulp.slurped){ // step 2
    
    gulp.slurped = true; // step 3
  }

  gulp.watch("../*.js", gulp.parallel(clean, gulp.parallel(htaccess, setupIndex, pages, sass, javascript, images, copy)));

  gulp.watch(PATHS.assets, copy);
  
  gulp.watch('src/public/index.{php}', gulp.series(setupIndex));
  gulp.watch('src/app/views/**/*.{html,phtml,php,volt}', gulp.series(pages, browser.reload));
  gulp.watch('src/public/assets/scss/**/*.scss', sass);
  gulp.watch('src/public/assets/js/**/*.js', gulp.series(javascript, browser.reload));
  gulp.watch('src/public/assets/img/**/*', gulp.series(images, browser.reload));
}
