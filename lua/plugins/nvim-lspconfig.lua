local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	require("neoconf").setup({})

	-- autopairs: brackets / quotes
	require("nvim-autopairs").setup({})

	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")

	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- ------- Language servers -------

	-- Lua (nvim config)
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	-- TypeScript / JavaScript (renamed from tsserver to ts_ls)
	lspconfig.ts_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
		cmd = { "typescript-language-server", "--stdio" },
	})

	-- ESLint LSP (replaces eslint_d-via-efm). Provides diagnostics + code actions
	-- and, via the autocmd below, runs `:EslintFixAll` on save.
	lspconfig.eslint.setup({
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				command = "EslintFixAll",
			})
		end,
	})

	-- Tailwind. Narrow default filetype list (40+) to what we actually use.
	lspconfig.tailwindcss.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"html",
			"css",
			"scss",
			"sass",
			"less",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"markdown",
			"php",
			"blade",
		},
	})

	-- HTML
	lspconfig.html.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "html" },
	})

	-- JSON
	lspconfig.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "json", "jsonc" },
	})

	-- YAML
	lspconfig.yamlls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			yaml = {
				keyOrdering = false,
				schemas = {
					["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
					["https://json.schemastore.org/github-action.json"] = "/.github/action.{yml,yaml}",
					["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
						"docker-compose.{yml,yaml}",
						"compose.{yml,yaml}",
					},
				},
			},
		},
	})

	-- Bash / sh
	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "sh", "bash", "zsh" },
	})

	-- Markdown
	lspconfig.marksman.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- Python (basedpyright — modern fork of pyright)
	lspconfig.basedpyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			basedpyright = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "openFilesOnly",
					typeCheckingMode = "standard",
				},
			},
		},
	})

	-- PHP / Blade (intelephense is a Node app — no local PHP needed)
	lspconfig.intelephense.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "php", "blade" },
		settings = {
			intelephense = {
				files = {
					associations = { "*.php", "*.blade.php" },
					maxSize = 5000000,
				},
				environment = {
					-- adjust if your docker image uses a different PHP version
					phpVersion = "8.3",
				},
			},
		},
	})

	-- Docker
	lspconfig.dockerls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
	lspconfig.docker_compose_language_service.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "yaml.docker-compose" },
		root_dir = lspconfig.util.root_pattern(
			"docker-compose.yaml",
			"docker-compose.yml",
			"compose.yaml",
			"compose.yml"
		),
		single_file_support = true,
	})

	-- ------- efm: linters + formatters -------

	local selene = require("efmls-configs.linters.selene")
	local stylua = require("efmls-configs.formatters.stylua")
	local ruff = require("efmls-configs.linters.ruff")
	local ruff_format = require("efmls-configs.formatters.ruff")
	local prettierd = require("efmls-configs.formatters.prettier_d")
	local fixjson = require("efmls-configs.formatters.fixjson")
	local hadolint = require("efmls-configs.linters.hadolint")
	local blade_formatter = require("efmls-configs.formatters.blade_formatter")

	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"python",
			"json",
			"jsonc",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"markdown",
			"yaml",
			"dockerfile",
			"blade",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			rootMarkers = { ".git/" },
			languages = {
				lua = { selene, stylua },
				python = { ruff, ruff_format },
				json = { fixjson },
				jsonc = { fixjson },
				javascript = { prettierd },
				javascriptreact = { prettierd },
				typescript = { prettierd },
				typescriptreact = { prettierd },
				markdown = { prettierd },
				yaml = { prettierd },
				dockerfile = { hadolint },
				blade = { blade_formatter },
			},
		},
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"folke/neoconf.nvim",
		"folke/lazydev.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
