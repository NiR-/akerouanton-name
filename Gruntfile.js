module.exports = function (grunt) {
    grunt.initConfig({
        less: {
            production: {
                options: {
                    paths: ["bower_components/bootstrap/less"], 
                    yuicompress: true
                }, 
                files: {
                    "assets/css/main.min.css": "assets/_less/main.less"
                }
            }
        }, 
        uglify: {
            jquery: {
                files: {
                    'assets/js/jquery.min.js': 'bower_components/jquery/jquery.js'
                }
            }
        }, 
        copy: {
            bootstrap: {
                files: [
                    {
                        expand: true, 
                        cwd: 'bower_components/bootstrap/dist/fonts/', 
                        src: ['**'], 
                        dest: 'assets/fonts/'
                    }
                ]
            }
        }, 
        exec: {
            build: {
                cmd: 'jekyll build'
            }, 
            serve: {
                cmd: 'jekyll serve'
            }, 
        }
    });

    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-exec');
    grunt.loadNpmTasks('grunt-contrib-watch');

    grunt.registerTask('default', ['less', 'uglify', 'copy', 'exec:build']);
    grunt.registerTask('serve', ['less', 'uglify', 'copy', 'exec:serve']);
};
