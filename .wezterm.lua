-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows

config.initial_cols = 95
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 25.0
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
-- config.default_cursor_style = "BlinkingBlock"
-- config.cursor_blink_rate = 800
config.colors = {
	cursor_bg = "fa5482",
}

config.window_padding = {
	bottom = 0,
}

config.window_background_opacity = 0.4
config.macos_window_background_blur = 50

-- Finally, return the configuration to wezterm:
return config
