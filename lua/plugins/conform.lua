-- conform.nvim — formatting (replaces the efm-langserver formatter half).
-- One line per filetype; adding a language is trivial. Format-on-save can be
-- toggled with :FormatToggle (see <leader>tf below) or per-buffer.
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "Format buffer/selection",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			jsonc = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			scss = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			blade = { "blade-formatter" },
			go = { "goimports", "gofumpt" },
			zig = { "zigfmt" },
			swift = { "swiftformat" },
			-- odin: falls back to ols LSP formatting (lsp_format below).
		},
		-- Custom formatter definitions for tools without a conform builtin.
		formatters = {
			["blade-formatter"] = {
				command = "blade-formatter",
				args = { "--stdin" },
				stdin = true,
			},
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 2000, lsp_format = "fallback" }
		end,
	},
	init = function()
		-- :FormatToggle [!]  — global (no bang) or buffer-local (with !)
		vim.api.nvim_create_user_command("FormatToggle", function(a)
			if a.bang then
				vim.b.disable_autoformat = not vim.b.disable_autoformat
			else
				vim.g.disable_autoformat = not vim.g.disable_autoformat
			end
		end, { bang = true, desc = "Toggle format-on-save" })
		vim.keymap.set("n", "<leader>tf", "<cmd>FormatToggle<cr>", { desc = "Toggle format-on-save (global)" })
	end,
}
