--[[------------------------------------------------------

  yaml test
  ---------

  ...

--]]------------------------------------------------------
local lub    = require 'lub'
local lut    = require 'lut'
local yaml   = require 'yaml'
local should = lut.Test('yaml')

function should.auto_load()
  assertTrue(yaml.load)
end

function should.load_hash()
  local simple = yaml.loadpath(lub.path '|fixtures/simple.yml')
  assertEqual('hello', simple.hash.a)
  assertEqual('lubyk', simple.hash.b)
end

function should.load_number()
  local simple = yaml.loadpath(lub.path '|fixtures/simple.yml')
  assertEqual(0.5, simple.number.a)
  assertEqual(3, simple.number.b)
end

function should.load_list()
  local simple = yaml.loadpath(lub.path '|fixtures/simple.yml')
  assertEqual('first',  simple.list[1])
  assertEqual('second', simple.list[2])
end

function should.loadpath()
  local simple = yaml.loadpath(lub.path '|fixtures/simple.yml')
  assertEqual('first',  simple.list[1])
  assertEqual('second', simple.list[2])
end

function should.useRefsAsSameObj()
  local refs = yaml.loadpath(lub.path '|fixtures/refs.yml')
  assertEqual('Jane',  refs.roles.boss.name)
  -- same obj
  assertTrue(refs.roles.wife == refs.roles.boss)
  assertTrue(refs.all[1]     == refs.roles.boss)
end

function should.parseMultipleValues()
  local a, b, c = yaml.load [[
--- 3
--- 4
--- 5
...
  ]]
  assertEqual(3, a)
  assertEqual(4, b)
  assertEqual(5, c)
end

function should.dump()
  assertMatch('b: 4', yaml.dump {a = {b = 4}})
end

function should.load()
  local data = yaml.load [[
hey: June
ok: true
  ]]
  assertEqual('June', data.hey)
  assertEqual(true, data.ok)
end

function should.dumpAndLoadAnchors()
  local l = { x = 1 }
  l.y = l
  local res = yaml.load(yaml.dump(l))
  assertEqual(res, res.y)
end

function should.disableAnchors()
  local l = { x = 1 }
  l.y = l
  -- true == safe loading
  local res = yaml.load(yaml.dump(l), true)
  assertNil(res.y)
end

function should.configure()
  assertPass(function()
    yaml.configure {
      load_set_metatables = false,
    }
  end)
end

function should.dumpSorted()
  yaml.configure {
    sort_table_keys = true,
  }
  local x = {
    dom     = 1,
    anna    = 2,
    louis   = 3,
    bernard = 4,
    armand  = 5,
    simon   = 6,
  }
  assertEqual([[
---
anna: 2
armand: 5
bernard: 4
dom: 1
louis: 3
simon: 6
]], yaml.dump(x))

  yaml.configure {
    sort_table_keys = false,
  }
end

function should.raiseErrorOnNonStringKeysAndSort()
  yaml.configure {
    sort_table_keys = true,
  }
  local x = {
    [{}]    = 0,
    dom     = 1,
    anna    = 2,
    louis   = 3,
    bernard = 4,
    armand  = 5,
    simon   = 6,
  }
  assertError('Key is not a string: cannot dump with sorted keys.', function()
    yaml.dump(x)
  end)

  yaml.configure {
    sort_table_keys = false,
  }
end
  
  

should:test()
