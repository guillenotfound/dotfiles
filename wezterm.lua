-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night'

config.font = wezterm.font 'MesloLGLDZ Nerd Font Mono'

-- config.leader = { key = '`', timeout_milliseconds = 1000 }
config.keys = {
  -- Sends ESC + b and ESC + f sequence, which is used
  -- for telling your shell to jump back/forward.
  {
    -- When the left arrow is pressed
    key = 'LeftArrow',
    -- With the "Option" key modifier held down
    mods = 'OPT',
    -- Perform this action, in this case - sending ESC + B
    -- to the terminal
    action = wezterm.action.SendKey {
      key = 'b',
      mods = 'ALT',
    },
  },
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = wezterm.action.SendKey {
      key = 'f',
      mods = 'ALT',
    },
  },

  {
    key = ',',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = wezterm.home_dir,
      args = { 'nvim', wezterm.config_file },
    },
  },

  { key = "|", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },

  {
    key = 'Enter',
    mods = 'CMD',
    action = wezterm.action.ToggleFullScreen
  },
}

config.set_environment_variables = {
  PATH = '/opt/homebrew/bin:' .. os.getenv('PATH')
}

config.enable_tab_bar = false
-- config.window_decorations = "NONE"

-- and finally, return the configuration to wezterm
return config
