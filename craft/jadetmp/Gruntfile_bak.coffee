'use strict'

module.exports = (grunt)->
  grunt.initConfig
    jade:
      compile:
        options:
          pretty: true
        files:
          'tmp.html':'tmp.jade'
    coffee:
      compile:
        files: [
          expand: true
          cwd: './'
          src: './gc.coffee'
          dest: './'
          ext: '.js'
        ]
    stylus:
      compile:
        options:
          compress: false
        files: [
          expand: true
          cwd: './'
          src: 'style.styl'
          dest: './'
          ext: '.css'
        ]
    watch:
      files: ['*.jade']
      tasks: 'jade'
  
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  
  grunt.registerTask 'default', ['watch']
