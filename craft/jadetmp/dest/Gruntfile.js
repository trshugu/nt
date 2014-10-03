(function() {
  'use strict';
  module.exports = function(grunt) {
    grunt.initConfig({
      jade: {
        compile: {
          options: {
            pretty: true
          },
          expand: true,
          cwd: './',
          src: '*.jade',
          dest: './dest',
          ext: '.html'
        }
      },
      coffee: {
        compile: {
          expand: true,
          cwd: './',
          src: '*.coffee',
          dest: './dest',
          ext: '.js'
        }
      },
      stylus: {
        compile: {
          options: {
            compress: false
          },
          expand: true,
          cwd: './',
          src: '*.styl',
          dest: './dest',
          ext: '.css'
        }
      },
      watch: {
        jade: {
          files: ['./*.jade'],
          tasks: 'jade'
        },
        coffee: {
          files: ['./*.coffee'],
          tasks: 'coffee'
        },
        stylus: {
          files: ['./*.styl'],
          tasks: 'stylus'
        }
      }
    });
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-stylus');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.registerTask('build', ['jade', 'coffee', 'stylus']);
    return grunt.registerTask('default', ['watch']);
  };

}).call(this);
