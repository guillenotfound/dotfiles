-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"

config.font = wezterm.font("MesloLGLDZ Nerd Font Mono")
config.font_size = 13

config.max_fps = 120

-- config.leader = { key = '`', timeout_milliseconds = 1000 }
-- TODO: missing command left/right
config.keys = {
	{
		key = "LeftArrow",
		mods = "OPT",
		action = act.SendKey({
			key = "b",
			mods = "ALT",
		}),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = act.SendKey({
			key = "f",
			mods = "ALT",
		}),
	},
	{
		key = "LeftArrow",
		mods = "CMD",
		action = act.SendKey({
			key = "a",
			mods = "CTRL",
		}),
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = act.SendKey({
			key = "e",
			mods = "CTRL",
		}),
	},
	{
		key = "Backspace",
		mods = "CMD",
		action = act.SendKey({
			key = "u",
			mods = "CTRL",
		}),
	},

	{
		key = ",",
		mods = "SUPER",
		action = act.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
			args = { "nvim", wezterm.config_file },
		}),
	},

	-- { key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	{
		key = "Enter",
		mods = "CMD",
		action = act.ToggleFullScreen, -- Uses rectangle
	},

	{
		key = "p",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "`" }),
			act.SendKey({ key = "p", mods = "CTRL" }),
		}),
	},

	{
		key = "j",
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ key = "`" }),
			act.SendKey({ key = "j", mods = "CTRL" }),
		}),
	},
}

config.set_environment_variables = {
	PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
}

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.window_close_confirmation = "NeverPrompt"

return config
