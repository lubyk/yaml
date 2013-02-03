--[[------------------------------------------------------

  yaml
  ----

  FIXME: description for module 'yaml'

--]]------------------------------------------------------
yaml = Autoload('yaml')
require 'yaml.vendor'

function yaml.loadpath(path)
  lk.deprecation('yaml', 'loadpath', 'yaml.load(lk.content(path))')
  return yaml.load(lk.content(path))
end
