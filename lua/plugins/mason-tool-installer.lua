-- Auto-install the formatters / linters used by conform.nvim + nvim-lint.
-- (mason-lspconfig only handles LSP servers; this fills the rest.)
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	dependencies = { "mason-org/mason.nvim" },
	opts = {
		ensure_installed = {
			-- lua
			"stylua", -- format
			"selene", -- lint
			-- python (ruff: format + lint)
			"ruff",
			-- web (prettierd: format; eslint LSP lints)
			"prettierd",
			-- shell (bashls uses shellcheck for linting if present)
			"shellcheck",
			-- docker
			"hadolint", -- lint
			-- blade
			"blade-formatter",
			-- go (zig fmt ships with the zig binary; nothing to install)
			"gofumpt",
			"goimports",
			-- swift
			"swiftformat",
		},
		auto_update = false,
		run_on_start = true,
	},
}
