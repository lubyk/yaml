--[[------------------------------------------------------

  yaml test
  ---------

  ...

--]]------------------------------------------------------
require 'lubyk'

local should = test.Suite('yaml')

function should.auto_load()
  assertTrue(yaml.loadpath)
end

function should.load_hash()
  local simple = yaml.load(fixture.readAll('simple.yml'))
  assertEqual('hello', simple.hash.a)
  assertEqual('lubyk', simple.hash.b)
end

function should.load_number()
  local simple = yaml.loadpath(fixture.path('simple.yml'))
  assertEqual(0.5, simple.number.a)
  assertEqual(3, simple.number.b)
end

function should.load_list()
  local simple = yaml.load(fixture.readAll('simple.yml'))
  assertEqual('first',  simple.list[1])
  assertEqual('second', simple.list[2])
end

function should.load_path()
  local simple = yaml.loadpath(fixture.path('simple.yml'))
  assertEqual('first',  simple.list[1])
  assertEqual('second', simple.list[2])
end

function should.use_refs_as_same_obj()
  local refs = yaml.load(fixture.readAll('refs.yml'))
  assertEqual('Jane',  refs.roles.boss.name)
  -- same obj
  assertTrue(refs.roles.wife == refs.roles.boss)
  assertTrue(refs.all[1]     == refs.roles.boss)
end

function should.dump()
  assertMatch('b: 4', yaml.dump {a = {b = 4}})
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

test.all()
