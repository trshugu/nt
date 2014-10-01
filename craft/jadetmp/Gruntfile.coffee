module.exports = (grunt) ->
    grunt.initConfig
        compass:
            dev:
                options:
                    config: 'config.rb'
                    environment: 'development'
                    force: true
            prod:
                options:
                    config: 'config.rb'
                    environment: 'production'
                    force: true
        concat:
            'css/styles.css': ['src/reset.css', 'src/webfonts.css', 'css/common.css']
            'js/functions.js': ['src/common.js']
        cssmin:
            compress:
                files:
                    'css/styles.min.css': ['css/styles.css']
                    'css/tablet.min.css': ['css/tablet.css']
                    'css/mobile.min.css': ['css/mobile.css']
        uglify:
            my_target:
                files:
                    'js/functions.min.js': ['js/functions.js']
        haml:
            one:
                files:
                    'index.html': 'src/index.haml'
        play:
            fanfare:
                file: './node_modules/grunt-play/sounds/end.mp3'
        watch:
            files: ['src/*.scss', 'src/*.js', 'src/*.haml']
            tasks: ['compass:prod', 'concat', 'cssmin', 'uglify', 'haml', 'play']

    for t of pkg.devDependencies
        if t.substring(0, 6) is 'grunt-'
            grunt.loadNpmTasks t

    grunt.registerTask 'default', ['compass:prod', 'concat', 'cssmin', 'uglify', 'haml', 'play']



