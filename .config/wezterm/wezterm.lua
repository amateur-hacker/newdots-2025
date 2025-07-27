-- __        __       _
-- \ \      / /__ ___| |_ ___ _ __ _ __ ___
--  \ \ /\ / / _ \_  / __/ _ \ '__| '_ ` _ \
--   \ V  V /  __// /| ||  __/ |  | | | | | |
--    \_/\_/ \___/___|\__\___|_|  |_| |_| |_|
--

local wezterm = require("wezterm")
local config = wezterm.config_builder()

config = {
	enable_wayland = true,
	enable_kitty_graphics = true,
	leader = { key = "raw:65", mods = "CTRL" }, -- raw:65(keycode) => space key
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font_with_fallback({
		{ family = "Maple Mono", weight = "Medium", harfbuzz_features = { "+calt", "+liga" } },
		"JetBrainsMono Nerd Font",
		"Noto Color Emoji",
		"Symbols Nerd Font Mono",
	}),
	font_size = 16,
	window_background_opacity = 1,
	window_close_confirmation = "NeverPrompt",
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	show_new_tab_button_in_tab_bar = false,
	tab_max_width = 1600,
	audible_bell = "Disabled",
	default_cursor_style = "SteadyUnderline",
	disable_default_key_bindings = true,
	window_frame = {
		font = wezterm.font({ family = "Maple Mono", weight = "Medium" }),
		font_size = 12.0,
	},
	keys = {
		{ key = "j", mods = "CTRL|SHIFT", action = wezterm.action.SpawnCommandInNewTab({ cwd = wezterm.home_dir }) },
		{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "raw:47", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") }, -- raw:47(keycode) => semicolon key
		{
			key = "raw:60",
			mods = "CTRL|SHIFT",
			action = wezterm.action.MoveTabRelative(1),
		}, -- raw:60(keycode) => period key
		{
			key = "raw:59",
			mods = "CTRL|SHIFT",
			action = wezterm.action.MoveTabRelative(-1),
		}, -- raw:59(keycode) => comma key
		{
			key = "c",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				local has_selection = window:get_selection_text_for_pane(pane) ~= ""
				if has_selection then
					window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
				else
					window:perform_action(wezterm.action.SendKey({ key = "c", mods = "CTRL" }), pane)
				end
			end),
		},
		{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
		{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
		-- { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("PrimarySelection") },
		{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
		{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
		{ key = "X", mods = "CTRL", action = wezterm.action.ActivateCopyMode },
		{
			key = "r",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ReloadConfiguration,
		},
	},
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT|CTRL",
		action = wezterm.action.MoveTab(i - 1),
	})
end

return config
