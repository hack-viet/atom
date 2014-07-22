path = require 'path'

module.exports = (grunt) ->
  grunt.registerTask 'output-build-filetypes', 'Log counts for each filetype in the built application', ->
    shellAppDir = grunt.config.get('atom.shellAppDir')

    types = {}
    grunt.file.recurse shellAppDir, (absolutePath, rootPath, relativePath, fileName) ->
      extension = path.extname(fileName) or fileName
      types[extension] ?= 0
      types[extension]++

    extensions = Object.keys(types).sort (extension1, extension2) ->
      types[extension2] - types[extension1]

    extensions.forEach (extension) ->
      grunt.log.error "#{extension}: #{types[extension]}"
