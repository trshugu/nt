'use strict'

module.exports = (grunt)->
  grunt.initConfig
    coffee:
      compile:
        files: [
          expand: true
          cwd: './'
          src: './gc.coffee'
          dest: './'
          ext: '.js'
        ]
    watch:
      files: ['gc.coffee']
      tasks: 'coffee'
  
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  
  grunt.registerTask 'default', ['watch']
