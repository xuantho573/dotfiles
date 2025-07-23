local submodules = require("utils.load-submodules")("mini")
return vim
  .iter(submodules)
  :map(function(_, value)
    return value
  end)
  :totable()
