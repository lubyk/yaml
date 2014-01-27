package = "yaml"
version = "1.0.0-1"
source = {
  url = 'https://github.com/lubyk/yaml/archive/REL-1.0.0.tar.gz',
  dir = 'yaml-REL-1.0.0',
}
description = {
  summary = "Very fast yaml parser based on libYAML by Kirill Simonov",
  detailed = [[
    This module is part of the Lubyk project.

    Main features are:
     - Fast and easy to use
     - Based on proven code (libYAML)
     - Support for table loops

     Read the documentation at http://doc.lubyk.org/yaml.html.
  ]],
  homepage = "http://doc.lubyk.org/yaml.html",
  license = "MIT"
}
dependencies = {
  "lua >= 5.1, < 5.3",
  "lub >= 1.0.3, < 1.1",
}
build = {
  type = 'builtin',
  modules = {
    -- Plain Lua files
    ['yaml'           ] = 'yaml/init.lua',
    -- C++ modules
    ['yaml.core'      ] = {
      sources = {
        'src/api.c',
        'src/b64.c',
        'src/dumper.c',
        'src/emitter.c',
        'src/loader.c',
        'src/lyaml.c',
        'src/parser.c',
        'src/reader.c',
        'src/scanner.c',
        'src/strtod.c',
        'src/writer.c',
      },
      incdirs = {'src'},
    },
  },
}


