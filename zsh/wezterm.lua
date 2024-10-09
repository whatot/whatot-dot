local wezterm = require 'wezterm'
local mux = wezterm.mux
local config = {}

config.font_size = 13.0
config.font = wezterm.font_with_fallback {'JetBrains Mono', 'Monaco'}
config.color_scheme = 'Monokai (terminal.sexy)'

-- all window about
config.window_background_gradient = {
    colors = {'#1e657d', 'black'},
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
            radius = 1.25
        }
    }
}
config.window_background_opacity = 0.9
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
}
wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

-- change the title of tab to current working directory.
-- ref:
-- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html#format-tab-title
-- https://wezfurlong.org/wezterm/config/lua/PaneInformation.html
-- https://wezfurlong.org/wezterm/config/lua/pane/get_current_working_dir.html
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local active_pane = tab.active_pane

    -- cwd is a URL object with file:// as beginning.
    local cwd = active_pane.current_working_dir
    if cwd == nil then
        return
    end

    -- get cwd in string format, https://wezfurlong.org/wezterm/config/lua/wezterm.url/Url.html
    local cwd_str = cwd.file_path

    -- shorten the path by using ~ as $HOME.
    local home_dir = os.getenv('HOME')
    return string.gsub(cwd_str, home_dir, '~')
end)

return config
