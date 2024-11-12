local wezterm = require "wezterm"
local os = require "os"
local mux = wezterm.mux
local act = wezterm.action
local config = {}

-- all show
config.font_size = 13.0
config.font = wezterm.font_with_fallback { "JetBrains Mono", "Monaco" }
config.color_scheme = "Monokai (terminal.sexy)"

-- all window about
config.window_background_gradient = {
  colors = { "#1e657d", "black" },
  orientation = {
    Radial = {
      -- Specifies the x coordinate of the center of the circle,
      -- in the range 0.0 through 1.0.  The default is 0.5 which
      -- is centered in the X dimension.
      cx = 1.0,
      -- Specifies the y coordinate of the center of the circle,
      -- in the range 0.0 through 1.0.  The default is 0.5 which
      -- is centered in the Y dimension.
      cy = 0.0,
      -- Specifies the radius of the notional circle.
      -- The default is 0.5, which combined with the default cx
      -- and cy values places the circle in the center of the
      -- window, with the edges touching the window edges.
      -- Values larger than 1 are possible.
      radius = 1.25,
    },
  },
}
config.window_background_opacity = 0.9
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- all tab about
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.prefer_to_spawn_tabs = true
config.tab_max_width = 32

-- reload
config.automatically_reload_config = false

-- https://wezfurlong.org/wezterm/config/lua/wezterm/target_triple.html
-- https://wezfurlong.org/wezterm/config/lua/keyassignment/ActivateTab.html
if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  -- update keys
  config.keys = {}
  for i = 1, 8 do
    -- ALT + number to activate that tab
    table.insert(config.keys, {
      key = tostring(i),
      mods = 'ALT',
      action = act.ActivateTab(i - 1),
    })
  end
end

return config
