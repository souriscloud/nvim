local opts = {
	ensure_installed = {
		"efm",
		"lua_ls",
		"tsserver",
		"tailwindcss",
		"html",
		"cssls",
		"jsonls",
		"gopls",
		"rust_analyzer",
	},
	automatic_installation = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	opts = opts,
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}
