--[[------------------------------------------------------
  # YAML parser for Lua <a href="https://travis-ci.org/lubyk/yaml"><img src="https://travis-ci.org/lubyk/yaml.png" alt="Build Status"></a> 

  This parser uses [libYAML](http://pyyaml.org/wiki/LibYAML) by Kirill Siminov
  with bindings by Andrew Danforth and some modifications by Gaspard Bucher.
  libYAML version 0.1.3. LibYAML is generally considered to be the best C YAML 1.1 implementation. 

  <html><a href="https://github.com/lubyk/yaml"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_green_007200.png" alt="Fork me on GitHub"></a></html>

  *MIT license* &copy; Kirill Siminov 2006, Andrew Danforth 2009.

  ## Installation
  
  With [luarocks](http://luarocks.org):

    $ luarocks install yaml
  
  ## Usage example

    local data = yaml.load(some_yaml)

    local yaml_string = yaml.dump(some_table)

--]]-----------------------------------------------------
local lub     = require 'lub'
local core    = require 'yaml.core'
local lib     = lub.Autoload 'yaml'

local load, dump, configure = core.load, core.dump, core.configure

-- Current version respecting [semantic versioning](http://semver.org).
lib.VERSION = '1.1.2'

lib.DEPENDS = { -- doc
  -- Compatible with Lua 5.1 to 5.3 and LuaJIT
  'lua >= 5.1, < 5.4',
  -- Uses [Lubyk base library](http://doc.lubyk.org/lub.html)
  'lub >= 1.0.3, < 2',
}

-- nodoc
lib.DESCRIPTION = {
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
  homepage = "http://doc.lubyk.org/yaml.html",
}

-- nodoc
lib.BUILD = {
  github = 'lubyk',
  includes  = {'src'},
  sources   = {'src/*.c'},
}

--[[

  # Lua table

  Lua tables works as sets. In Lua, there is no distinction between an array and
  a dictionary whereas YAML makes this distinction. When dumping a table, the
  library has to choose between these two types. Here is the selection rule:

  + array: The table contains an element in index position `1`.

  ## Lua

  Some lua code
  
    local data = {
      { job = 'Car wash',
        duration = 1.5,
        comment = 'The car was really filthy.'
      },
      { job = 'Create website',
        duration = 6.25,
        comment = 'Using bootstrap template.'
      }
    }
    -- Create a loop
    data[1].link = data

  ## YAML

  And the equivalent yaml using `yaml.dump(data)`:
  
    #yaml
    --- &0
    - link: *0
      duration: 1.5
      comment: The car was really filthy.
      job: Car wash
    - duration: 6.25
      comment: Using bootstrap template.
      job: Create website

--]]------------------------------------------------------

-- # Class methods

-- Parse a `string` containing yaml content and return lua values. If the second
-- argument `safe` is true, the library will not generate aliases in tables.
--
-- Note that if there are more then on value in the YAML content, this function
-- will return multiple values. Example:
--
--   local a, b, c = yaml.load [[
--   --- 3
--   --- 4
--   --- 5
--   ...
--   ]]
--   --> a = 3, b = 4, c = 5
--
-- function lib.load(string, safe)

-- nodoc
lib.load = load

-- Parse the YAML content of the file at `path` and return lua values. Uses
-- yaml.load internally.
function lib.loadpath(path)
  return load(lub.content(path))
end

-- Dump all lua values in the vararg as YAML. Note that when using 'load' on
-- the produced content, multiple values will be returned.
-- function lib.dump(...)

-- nodoc
lib.dump = dump

-- Configure parser. Pass a table setting options to true or false. The default
-- value is shown in parenthesis.
--
-- WARN Please note that this configuration alters parsing globaly and should be
-- avoided. If such configuration is often needed, please consult the maintainer
-- so that we can move such configuration inside a Parser object instead of
-- using global settings.
--
-- + dump_auto_array:           (true)
-- + dump_error_on_unsupported: (false)
-- + dump_check_metatables:     (true)
-- + load_set_metatables:       (true)
-- + load_numeric_scalars:      (true)
-- + load_nulls_as_nil:         (false)
-- + sort_table_keys:           (false)
-- function lib.configure(options)

-- nodoc
lib.configure = configure

return lib
