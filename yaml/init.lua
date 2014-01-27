--[[------------------------------------------------------
  # Very fast yaml parser for Lua <a href="https://travis-ci.org/lubyk/yaml"><img src="https://travis-ci.org/lubyk/yaml.png" alt="Build Status"></a> 

  This parser uses [libYAML](http://pyyaml.org/wiki/LibYAML) by Kirill Siminov
  with bindings by Andrew Danforth and some modifications by Gaspard Bucher.
  libYAML version 0.1.3.

  <html><a href="https://github.com/lubyk/yaml"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_green_007200.png" alt="Fork me on GitHub"></a></html>

  This module is part of the [lubyk](http://lubyk.org) project. *MIT license*
  &copy; Gaspard Bucher 2014.

  ## Installation
  
  With [luarocks](http://luarocks.org):

    $ luarocks install yaml
  
  ## Usage example

    local data = yaml.parse(some_yaml)

    local yaml_string = yaml.dump(some_table)

--]]-----------------------------------------------------
local lub     = require 'lub'
local core    = require 'yaml.core'
local lib     = lub.Autoload 'yaml'

local parse, dump = core.load, core.dump

-- Current version respecting [semantic versioning](http://semver.org).
lib.VERSION = '1.0.0'

lib.DEPENDS = { -- doc
  -- Compatible with Lua 5.1, 5.2 and LuaJIT
  'lua >= 5.1, < 5.3',
  -- Uses [Lubyk base library](http://doc.lubyk.org/lub.html)
  'lub >= 1.0.3, < 1.1',
}

--[[

  # Lua table

  Lua tables works as sets. In Lua, there is no distinction between an array and
  a dictionary whereas YAML makes this distinction. When dumping a table, the
  library has to choose between these two types. Here is the selection rule:

  + array: The table contains an element in index position `1`.

  ## Lua
  
    TODO

  ## XML

  And the equivalent yaml:

    #txt
    TODO

--]]------------------------------------------------------

-- # Class methods

-- Parse a `string` containing yaml content and return a table. Uses
-- yaml.Parser internally. If the second argument `safe` is true, the
-- library will not generate aliases in tables.
-- function lib.parse(string, safe)

-- nodoc
lib.parse = parse

-- Parse the YAML content of the file at `path` and return a lua table. Uses
-- yaml.Parser internally.
function lib.load(path)
  return parse(lub.content(path))
end

-- Dump lua content as YAML.
-- function lib.dump(data)

-- nodoc
lib.dump = dump

return lib
