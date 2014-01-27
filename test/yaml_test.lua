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
  local simple = yaml.load(lub.path '|fixtures/simple.yml')
  assertEqual('hello', simple.hash.a)
  assertEqual('lubyk', simple.hash.b)
end

function should.load_number()
  local simple = yaml.load(lub.path '|fixtures/simple.yml')
  assertEqual(0.5, simple.number.a)
  assertEqual(3, simple.number.b)
end

function should.load_list()
  local simple = yaml.load(lub.path '|fixtures/simple.yml')
  assertEqual('first',  simple.list[1])
  assertEqual('second', simple.list[2])
end

function should.load_path()
  local simple = yaml.load(lub.path '|fixtures/simple.yml')
  assertEqual('first',  simple.list[1])
  assertEqual('second', simple.list[2])
end

function should.use_refs_as_same_obj()
  local refs = yaml.load(lub.path '|fixtures/refs.yml')
  assertEqual('Jane',  refs.roles.boss.name)
  -- same obj
  assertTrue(refs.roles.wife == refs.roles.boss)
  assertTrue(refs.all[1]     == refs.roles.boss)
end

function should.dump()
  assertMatch('b: 4', yaml.dump {a = {b = 4}})
end

function should.parse()
  local data = yaml.parse [[
hey: June
ok: true
  ]]
  assertEqual('June', data.hey)
  assertEqual(true, data.ok)
end

function should.dumpAndLoadAnchors()
  local l = { x = 1 }
  l.y = l
  local res = yaml.parse(yaml.dump(l))
  assertEqual(res, res.y)
end

function should.disableAnchors()
  local l = { x = 1 }
  l.y = l
  -- true == safe loading
  local res = yaml.parse(yaml.dump(l), true)
  assertNil(res.y)
end

should:test()
