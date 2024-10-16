local wezterm = require 'wezterm'
local os = require 'os'
local mux = wezterm.mux
local config = {}

-- 检查文件是否存在
local function file_exists(path)
    local file = io.open(path, "r")
    if file then
        file:close()
        return true
    else
        return false
    end
end

-- 遍历候选路径，找到第一个存在的文件
local function find_first(paths, default)
    for _, path in ipairs(paths) do
        if file_exists(path) then
            return path
        end
    end
    return default
end

-- fish
local fish_candidates = {"/opt/homebrew/bin/fish", "/usr/local/bin/fish", "/usr/bin/fish", "/usr/local/bin/fish"}
local fish_path = find_first(fish_candidates, fish_candidates[0])
config.default_prog = {fish_path, '-l'}

-- all show
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
config.window_close_confirmation = 'NeverPrompt'

-- all tab about
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.prefer_to_spawn_tabs = true
config.tab_max_width = 32

-- reload
config.automatically_reload_config = false

return config
