-- Catppuccin (Mocha) — colorscheme. transparent_background lets your terminal
-- background / blur show through. Integrations recolor each plugin to match.
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "mocha",
		transparent_background = true,
		term_colors = true,
		integrations = {
			blink_cmp = true,
			flash = true,
			gitsigns = true,
			illuminate = { enabled = true },
			markdown = true,
			mason = true,
			native_lsp = { enabled = true },
			noice = true,
			notify = true,
			nvimtree = true,
			snacks = true,
			telescope = { enabled = true },
			treesitter = true,
			lsp_trouble = true,
			which_key = true,
			dashboard = true,
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
