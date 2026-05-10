-- Auto-install formatters / linters that efm pipes through.
-- Mason-lspconfig only handles LSPs; this fills the gap for everything else.
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	dependencies = { "williamboman/mason.nvim" },
	opts = {
		ensure_installed = {
			-- lua
			"stylua",
			"selene",
			-- python (single tool, lint + format)
			"ruff",
			-- web (formatter; eslint LSP handles linting)
			"prettierd",
			-- json
			"fixjson",
			-- docker
			"hadolint",
			-- blade (formatter)
			"blade-formatter",
		},
		auto_update = false,
		run_on_start = true,
	},
}
