return {
  "TaDaa/vimade",
  version = "2.5.0",
  opts = {
    recipe = { "minimalist", { animate = false } },
    ncmode = "buffers",
    fadelevel = 0.4,
    tint = {
      bg = {
        rgb = { 128, 128, 128 },
        intensity = 0.6,
      },
    },
    blocklist = {
      non_float = function(win, current)
        if (win.win_config["relative"] == "") and (current and current.win_config["relative"] ~= "") then
          return false
        end
        return true
      end,
    },
    checkinterval = 500,
  },
}
