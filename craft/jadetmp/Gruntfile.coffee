'use strict'

module.exports = (grunt)->
  grunt.initConfig
    jade:
      compile:
        options:
          pretty: true
        expand: true
        cwd: './'
        src: '*.jade'
        dest: './'
        ext: '.html'
    coffee:
      compile:
        expand: true
        cwd: './'
        src: '*.coffee'
        dest: './'
        ext: '.js'
    stylus:
      compile:
        options:
          compress: false
        expand: true
        cwd: './'
        src: '*.styl'
        dest: './'
        ext: '.css'
    watch:
      jade:
        files: ['./*.jade']
        tasks: 'jade'
      coffee:
        files: ['./*.coffee']
        tasks: 'coffee'
      stylus:
        files: ['./*.styl']
        tasks: 'stylus'
  
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  
  grunt.registerTask 'default', ['watch']
