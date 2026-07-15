-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows

config.initial_cols = 95
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 30.0
-- config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font = wezterm.font_with_fallback({
	{ family = "UbuntuMono Nerd Font", weight = "Bold" },
	{ family = "JetBrainsMono Nerd Font", weight = "Bold" },
	"PingFang SC",
	"Hiragino Sans GB",
	"Apple SD Gothic Neo",
	"Thonburi",
	"Arial Hebrew",
	"Apple Symbols",
})

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
-- config.default_cursor_style = "BlinkingBlock"
-- config.cursor_blink_rate = 800
config.colors = {
	cursor_bg = "fa5482",
	foreground = "#b3b3b3",
}

config.color_scheme = "Rasi (terminal.sexy)"
-- config.color_scheme = "Royal (Gogh)"
-- config.color_scheme = "Molokai"

config.window_padding = {
	bottom = 0,
}

config.window_background_opacity = 0.4
config.macos_window_background_blur = 50

-- Finally, return the configuration to wezterm:
return config
