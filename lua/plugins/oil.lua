-- oil.nvim — edit your filesystem like a buffer
--   <leader>-     — open parent dir as buffer
--   -             — open parent dir (when inside a file)
--   Inside oil: edit names, :w to apply (renames/creates/deletes are real fs ops)
--   g?            — show help
return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		default_file_explorer = false, -- keep nvim-tree as the sidebar
		view_options = {
			show_hidden = true,
		},
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-v>"] = "actions.select_vsplit",
			["<C-x>"] = "actions.select_split",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["g."] = "actions.toggle_hidden",
		},
	},
	keys = {
		{ "-",         "<cmd>Oil<cr>",        desc = "Open parent directory" },
		{ "<leader>-", "<cmd>Oil --float<cr>", desc = "Open parent directory (float)" },
	},
}
