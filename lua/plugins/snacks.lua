-- snacks.nvim — folke's QoL bundle. Enabled here:
--   dashboard  — start screen (recent files / quick actions)
--   indent     — indent guides + animated scope (replaces indent-blankline)
--   scroll     — smooth scrolling
--   bigfile / quickfile — perf for large files & fast single-file startup
-- Notifications stay with noice + nvim-notify, so snacks.notifier is left off.
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		indent = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
					{ icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":Telescope find_files cwd=" .. vim.fn.stdpath("config"),
					},
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
	},
}
