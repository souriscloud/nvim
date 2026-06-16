-- Auto-installs the LSP servers Mason can manage. sourcekit (Swift) is NOT
-- listed: it ships with the Xcode/Swift toolchain, not Mason.
return {
	"mason-org/mason-lspconfig.nvim",
	event = "BufReadPre",
	dependencies = "mason-org/mason.nvim",
	opts = {
		-- We enable servers explicitly in lua/plugins/nvim-lspconfig.lua via
		-- vim.lsp.enable(). Disable auto-enable so a stray installed server
		-- (e.g. a leftover efm) can't attach itself behind our back.
		automatic_enable = false,
		ensure_installed = {
			"lua_ls",
			"ts_ls",
			"eslint",
			"tailwindcss",
			"html",
			"jsonls",
			"yamlls",
			"bashls",
			"marksman",
			"basedpyright",
			"intelephense",
			"dockerls",
			"docker_compose_language_service",
			"gopls",
			"zls",
			"ols",
		},
	},
}
