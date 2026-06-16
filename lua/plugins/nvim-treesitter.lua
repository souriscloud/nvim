-- nvim-treesitter — rewritten "main" branch (requires Neovim 0.12+).
-- Differences from the legacy branch:
--   * no configs.setup({ ensure_installed, highlight, indent }) — instead we
--     call require("nvim-treesitter").install(...) and start highlighting via
--     a FileType autocmd.
--   * incremental selection was removed upstream (no replacement here).
--   * custom community parsers register through the `User TSUpdate` event.
-- Parsers generated from grammar.js (Swift, Blade) need `tree-sitter-cli` >=0.25
-- on PATH (brew install tree-sitter-cli) so it can emit ABI 15 for Nvim 0.12.

-- Languages with parsers in the official registry.
local ensure = {
	"markdown",
	"markdown_inline",
	"json",
	"javascript",
	"typescript",
	"tsx",
	"yaml",
	"toml",
	"html",
	"css",
	"bash",
	"lua",
	"luadoc",
	"vim",
	"vimdoc",
	"dockerfile",
	"gitignore",
	"python",
	"vue",
	"regex",
	"php",
	"php_only",
	"swift",
	"go",
	"gomod",
	"gosum",
	"zig",
	"odin",
}

-- Register the community Blade parser (not in the official registry).
local function register_blade()
	require("nvim-treesitter.parsers").blade = {
		install_info = {
			url = "https://github.com/EmranMR/tree-sitter-blade",
			branch = "main",
			files = { "src/parser.c" },
			queries = "queries",
		},
		tier = 3,
	}
	vim.treesitter.language.register("blade", { "blade" })
end

local config = function()
	require("nvim-treesitter").setup()

	register_blade()
	-- jsonc has no dedicated parser; reuse the json parser for it.
	vim.treesitter.language.register("json", { "json", "jsonc" })
	-- Re-register on :TSUpdate (the update flow rebuilds the parser table).
	vim.api.nvim_create_autocmd("User", {
		pattern = "TSUpdate",
		callback = register_blade,
	})

	-- Install the official parsers + blade (async; skips already-installed).
	require("nvim-treesitter").install(ensure)
	require("nvim-treesitter").install({ "blade" })

	-- Start highlighting (and treesitter indentation) whenever a buffer has a
	-- parser available. pcall guards filetypes without one.
	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("TreesitterStart", {}),
		callback = function(args)
			if pcall(vim.treesitter.start, args.buf) then
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end,
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = config,
}
