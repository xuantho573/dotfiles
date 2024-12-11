-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local mux = wezterm.mux

-- This is where you actually apply your config choices
local light_scheme = "Catppuccin Latte"
local dark_scheme = "Catppuccin Macchiato"

local light_colors = {
  surface_0 = "#ccd0da",
  surface_1 = "#bcc0cc",
  surface_2 = "#acb0be",
  text = "#4c4f69",
  accent = "#04a5e5",
}
local dark_colors = {
  surface_0 = "#363a4f",
  surface_1 = "#494d64",
  surface_2 = "#5b6078",
  text = "#cad3f5",
  accent = "#91d7e3",
}

-- For example, changing the color scheme:
function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return "Light"
end

function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return dark_scheme
  else
    return light_scheme
  end
end

function get_colors(appearance)
  if appearance:find("Dark") then
    return dark_colors
  else
    return light_colors
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())
-- config.default_domain = 'WSL:Debian'
config.font = wezterm.font("FiraCode Nerd Font")
config.audible_bell = "Disabled"
config.font_size = 12
config.default_cursor_style = "SteadyBar"
config.use_fancy_tab_bar = true
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.window_background_opacity = 1
-- config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
-- config.integrated_title_button_style = 'Windows'
-- config.integrated_title_button_alignment = "Left"

config.window_frame = {
  active_titlebar_bg = get_colors(get_appearance()).surface_0,
  font_size = 12,
}

config.window_padding = {
  left = "8pt",
  right = "8pt",
  top = "4pt",
  bottom = "4pt",
}

config.colors = {
  tab_bar = {
    inactive_tab_edge = "transparent",
  },
}

wezterm.on("gui-startup", function()
  local startup_tab, startup_pane, startup_window = mux.spawn_window({})
  -- startup_window:gui_window():maximize()
end)

local SOLID_LEFT = wezterm.nerdfonts.ple_left_half_circle_thick
local SOLID_RIGHT = wezterm.nerdfonts.ple_right_half_circle_thick

function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local colors = get_colors(get_appearance())
  local edge_background = colors.surface_0
  local background = colors.surface_1
  local edge_foreground = colors.surface_1
  local foreground = colors.text

  if tab.is_active then
    background = colors.accent
    edge_foreground = colors.accent
    foreground = colors.surface_0
  end

  local title = wezterm.truncate_right(tab_title(tab), max_width - 2)

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT },
  }
end)

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
  local zoomed = ""
  if tab.active_pane.is_zoomed then
    zoomed = "[Z] "
  end

  local index = ""
  if #tabs > 1 then
    index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
  end

  -- return zoomed .. index .. tab.active_pane.title
  -- return ''
end)

config.keys = {
  {
    key = "s",
    mods = "CTRL|SHIFT",
    action = wezterm.action_callback(function(window)
      local old_dim = window:get_dimensions()
      window:maximize()
      local new_dim = window:get_dimensions()
      if (old_dim.pixel_width == new_dim.pixel_width) and (old_dim.pixel_height == new_dim.pixel_height) then
        window:restore()
      end
    end),
  },
}

return config
