-- nvim-lint — standalone linters (replaces the efm-langserver linter half).
-- ESLint stays as an LSP; ruff lints Python, selene lints Lua, hadolint
-- lints Dockerfiles. Lint runs on read / write / leaving insert mode.
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			lua = { "selene" },
			python = { "ruff" },
			dockerfile = { "hadolint" },
		}

		local grp = vim.api.nvim_create_augroup("NvimLint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = grp,
			callback = function()
				-- No-ops automatically for filetypes without a configured linter.
				lint.try_lint()
			end,
		})
	end,
}
