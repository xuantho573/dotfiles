local M = {}
local _env = {} -- private, not exposed to vim.env

local function load_env(path)
  local file = io.open(path, "r")
  if not file then
    return
  end

  for line in file:lines() do
    ---@type string
    line = line

    -- Skip comments and blank lines
    if not line:match("^%s*#") and not line:match("^%s*$") then
      local key, value = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
      if key and value then
        -- Strip surrounding quotes if present
        value = value:match('^"(.*)"$') or value:match("^'(.*)'$") or value
        _env[key] = value
      end
    end
  end

  file:close()
end

-- Load on require
load_env(vim.fs.joinpath(vim.fn.stdpath("config"), ".env"))

-- Safe getter
---@overload fun(key: string): string
---@overload fun(key: string, strict: false): string
function M.get(key, strict)
  local value = _env[key]

  if strict ~= false and value == nil then
    error("Missing required env var: " .. key)
  end

  return value
end

return M
