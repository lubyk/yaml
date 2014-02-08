#!/usr/bin/env lua
local lub = require 'lub'
local lib = require 'yaml'

local def = {
  description = {
    summary = "Very fast yaml parser based on libYAML by Kirill Simonov",
    author  = "Andrew Danforth, Gaspard Bucher",
    license = "MIT",

    detailed = [[
    This module is a Lua binding for Kirill Siminov's excellent LibYAML. LibYAML is generally considered to be the best C YAML 1.1 implementation.

    Main features are:
     - Fast and easy to use
     - Based on proven code (libYAML)
     - Support for table loops
     - No external dependencies

     Read the documentation at http://doc.lubyk.org/yaml.html.
    ]],
    homepage = "http://doc.lubyk.org/"..lib.type..".html",
  },

  includes  = {'src'},
  libraries = {},
  platlibs = {},
}

-- Platform specific sources or link libraries
def.platspec = def.platspec or lub.keys(def.platlibs)

--- End configuration

local tmp = lub.Template(lub.content(lub.path '|rockspec.in'))
lub.writeall(lib.type..'-'..lib.VERSION..'-1.rockspec', tmp:run {lib = lib, def = def, lub = lub})

tmp = lub.Template(lub.content(lub.path '|dist.info.in'))
lub.writeall('dist.info', tmp:run {lib = lib, def = def, lub = lub})

tmp = lub.Template(lub.content(lub.path '|CMakeLists.txt.in'))
lub.writeall('CMakeLists.txt', tmp:run {lib = lib, def = def, lub = lub})


