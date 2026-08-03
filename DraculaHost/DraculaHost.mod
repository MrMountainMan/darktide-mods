return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`DraculaHost` encountered an error loading the Darktide Mod Framework.")

		new_mod("DraculaHost", {
			mod_script       = "DraculaHost/scripts/mods/DraculaHost/DraculaHost",
			mod_data         = "DraculaHost/scripts/mods/DraculaHost/DraculaHost_data",
			mod_localization = "DraculaHost/scripts/mods/DraculaHost/DraculaHost_localization",
		})
	end,
	packages = {},
}
