return function(submodules_path)
  local submodules = vim.fs.dir(vim.fs.joinpath(vim.fn.stdpath("config"), "lua/plugins", submodules_path))

  return vim
    .iter(submodules)
    :map(function(name)
      local module_name = string.gsub(name, ".lua", "")
      return module_name
    end)
    :map(function(name)
      return { [name] = require("plugins" .. "." .. submodules_path .. "." .. name) }
    end)
    :fold({}, function(...)
      return vim.tbl_extend("force", ...)
    end)
end
