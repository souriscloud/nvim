return {
	{ "folke/neoconf.nvim", cmd = "Neoconf" },

	-- lazydev: faster, modern replacement for neodev. Teaches lua_ls about
	-- Neovim's lua API + your plugin runtime so config edits get real autocomplete.
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
