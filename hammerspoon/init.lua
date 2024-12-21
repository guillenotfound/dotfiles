function bindHotkey(appName, key)
	hs.hotkey.bind({ "Alt" }, key, function()
		local app = hs.application.find(appName)
		if app then
			if app:isFrontmost() then
				app:hide()
			else
				app:activate()
				-- local nowspace = hs.spaces.focusedSpace()
				-- local screen = hs.screen.mainScreen()
				-- local app_window = app:mainWindow()
				-- hs.spaces.moveWindowToSpace(app_window, nowspace)
				-- local max = screen:fullFrame()
				-- local f = app_window:frame()
				-- -- f.x = max.x
				-- -- f.y = max.y
				-- -- f.w = max.w
				-- -- f.h = max.h
				-- hs.timer.doAfter(0.2, function()
				-- 	app_window:setFrame(f)
				-- end)
				-- app_window:focus()
			end
		end
	end)
end

bindHotkey("Wezterm", "space")
bindHotkey("Slack", "s")
bindHotkey("Chrome", "c")

-- https://github.com/jasonrudolph/ControlEscape.spoon/tree/main?tab=readme-ov-file#installation
hs.loadSpoon("ControlEscape"):start()
