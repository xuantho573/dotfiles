local M = {}

---@param highlight_num integer
---@return string
M.highlight_to_hex = function(highlight_num)
  return string.format("#%06x", highlight_num)
end

---@param hex string
---@return [integer, integer, integer]
M.hex_to_rgb = function(hex)
  local val = hex:sub(2)

  -- short form hex
  if string.len(val) == 3 then
    val = val:rep(2)
  end

  local r = tonumber(val:sub(1, 2), 16)
  local g = tonumber(val:sub(3, 4), 16)
  local b = tonumber(val:sub(5, 6), 16)

  return { r, g, b }
end

return M
