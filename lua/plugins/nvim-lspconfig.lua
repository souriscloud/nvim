local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	require("neoconf").setup({})
	require("nvim-autopairs").setup({})

	-- Diagnostic signs (modern API; replaces vim.fn.sign_define loop)
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
				[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
				[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
				[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			},
		},
		virtual_text = { spacing = 2, prefix = "●" },
		severity_sort = true,
		float = { border = "rounded", source = true },
	})

	-- Global capabilities (cmp + base) — apply to every server via "*"
	local capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities()
	)
	vim.lsp.config("*", { capabilities = capabilities })

	-- ------- Per-server config (merged with nvim-lspconfig's defaults) -------

	vim.lsp.config("lua_ls", {
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

	vim.lsp.config("ts_ls", {
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_markers = { "package.json", "tsconfig.json", ".git" },
	})

	-- ESLint: defaults from nvim-lspconfig are fine; we add EslintFixAll
	-- via the LspAttach autocmd in config/autocmds.lua.
	vim.lsp.config("eslint", {})

	vim.lsp.config("tailwindcss", {
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

	vim.lsp.config("html", { filetypes = { "html" } })

	vim.lsp.config("jsonls", { filetypes = { "json", "jsonc" } })

	vim.lsp.config("yamlls", {
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

	vim.lsp.config("bashls", { filetypes = { "sh", "bash", "zsh" } })

	vim.lsp.config("marksman", {})

	vim.lsp.config("basedpyright", {
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

	vim.lsp.config("intelephense", {
		filetypes = { "php", "blade" },
		settings = {
			intelephense = {
				files = {
					associations = { "*.php", "*.blade.php" },
					maxSize = 5000000,
				},
				environment = {
					phpVersion = "8.3",
				},
			},
		},
	})

	vim.lsp.config("dockerls", {})

	vim.lsp.config("docker_compose_language_service", {
		filetypes = { "yaml.docker-compose" },
		root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
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

	vim.lsp.config("efm", {
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

	-- Turn them all on
	vim.lsp.enable({
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
