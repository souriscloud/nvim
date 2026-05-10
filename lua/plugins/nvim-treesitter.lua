local config = function()
	-- Register the community Blade parser (not in nvim-treesitter's default list)
	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.blade = {
		install_info = {
			url = "https://github.com/EmranMR/tree-sitter-blade",
			files = { "src/parser.c", "src/scanner.c" },
			branch = "main",
		},
		filetype = "blade",
	}

	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"markdown",
			"markdown_inline",
			"json",
			"jsonc",
			"javascript",
			"typescript",
			"yaml",
			"toml",
			"html",
			"css",
			"bash",
			"lua",
			"luadoc",
			"vim",
			"vimdoc",
			"tsx",
			"dockerfile",
			"gitignore",
			"python",
			"vue",
			"regex",
			"php",
			"php_only",
			"blade",
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-Space>",
				node_incremental = "<C-Space>",
				node_decremental = "<BS>",
				scope_incremental = "<C-s>",
			},
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	-- Pin to the legacy API. Master's `c82bf96` (Mar 2026) merged the rewrite
	-- and removed `nvim-treesitter.configs.setup()` + `get_parser_configs()`,
	-- which our config relies on. The rewrite needs Nvim 0.12+.
	tag = "v0.9.3",
	lazy = false,
	build = ":TSUpdate",
	config = config,
}
