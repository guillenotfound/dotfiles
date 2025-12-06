function bindHotkey(appName, key)
	hs.hotkey.bind({ "Alt" }, key, function()
		local app = hs.application.find(appName)
		if app then
			if app:isFrontmost() then
				app:hide()
			else
				app:activate()
			end
		else
			hs.application.launchOrFocus(appName)
		end
	end)
end

bindHotkey("Slack", "s")
bindHotkey("Wezterm", "space")
bindHotkey("Zen", "c")
-- bindHotkey("Brave", "b")
-- bindHotkey("Ghostty", "space")
-- bindHotkey("Zoom", "z")

-- https://github.com/jasonrudolph/ControlEscape.spoon/tree/main?tab=readme-ov-file#installation
hs.loadSpoon("ControlEscape"):start()
