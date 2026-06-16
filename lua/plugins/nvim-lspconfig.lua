local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	require("neoconf").setup({})
	require("nvim-autopairs").setup({})

	-- Diagnostic signs + UI (modern vim.diagnostic API)
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

	-- Global capabilities (blink.cmp + base) — applied to every server via "*".
	-- blink is a dependency below, so it is loaded before any server attaches.
	local capabilities = require("blink.cmp").get_lsp_capabilities()
	vim.lsp.config("*", { capabilities = capabilities })

	-- ------- Per-server config (merged with nvim-lspconfig's defaults) -------

	-- lua_ls: lazydev + .luarc.json supply the Neovim runtime/`vim` globals,
	-- so we only add editor niceties here.
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				hint = { enable = true },
				workspace = { checkThirdParty = false },
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

	-- ESLint: defaults are fine; EslintFixAll on save is wired in
	-- config/autocmds.lua via the LspAttach hook.
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

	-- ------- Systems languages -------

	vim.lsp.config("gopls", {
		settings = {
			gopls = {
				gofumpt = true,
				staticcheck = true,
				analyses = {
					unusedparams = true,
					unusedwrite = true,
					nilness = true,
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	})

	vim.lsp.config("zls", {
		settings = {
			zls = {
				enable_build_on_save = false,
				semantic_tokens = "partial",
			},
		},
	})

	-- ols: Odin language server (installed via Mason once you start writing Odin).
	vim.lsp.config("ols", {})

	-- sourcekit-lsp ships with the Swift/Xcode toolchain (not Mason-installable).
	-- It needs dynamic file-watching registration to track non-open files.
	vim.lsp.config("sourcekit", {
		capabilities = vim.tbl_deep_extend("force", capabilities, {
			workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
		}),
	})

	-- Turn them all on. (Formatting/linting is handled by conform.nvim +
	-- nvim-lint, not an LSP — see lua/plugins/conform.lua and nvim-lint.lua.)
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
		"gopls",
		"zls",
		"ols",
		"sourcekit",
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"mason-org/mason.nvim",
		"folke/neoconf.nvim",
		"folke/lazydev.nvim",
		"saghen/blink.cmp",
	},
}
