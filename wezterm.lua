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

config.initial_cols = 100
config.initial_rows = 25

-- So far `update-status` is the only event that triggers frequently enough such that we can update the `font_size`
wezterm.on("update-status", function(window)
	-- IF the window is not focused prevent changing any settings
	if not window:is_focused() then
		return
	end

	-- local screens = wezterm.gui.screens()
	-- local active_screen = screens.active
	-- print("win", active_screen)
	-- print("wwindow", window:get_dimensions())

	local active_screen_name = wezterm.gui.screens().active.name
	if active_screen_name == "DELL S2722QC" then
		-- window:set_inner_size(active_screen.width, active_screen.height)
		-- window:set_position(0, 0)
		window:set_config_overrides({
			font_size = 18,
		})
	elseif active_screen_name == "Built-in Retina Display" then
		-- window:set_inner_size(active_screen.width, active_screen.height)
		-- window:set_position(0, 0)
		window:set_config_overrides({
			font_size = 13,
		})
	end
end)

return config
