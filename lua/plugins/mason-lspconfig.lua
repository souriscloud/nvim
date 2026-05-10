return {
	"williamboman/mason-lspconfig.nvim",
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
	opts = {
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
			"efm",
		},
	},
}
