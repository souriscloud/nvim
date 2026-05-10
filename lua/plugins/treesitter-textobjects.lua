-- nvim-treesitter-textobjects — gives you text objects like:
--   vif / vaf      — inner / around function
--   vic / vac      — inner / around class
--   via / vaa      — inner / around argument
--   ]f  / [f       — next / prev function start
--   ]c  / [c       — next / prev class start
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = "nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = { ["<leader>sa"] = "@parameter.inner" },
					swap_previous = { ["<leader>sA"] = "@parameter.inner" },
				},
			},
		})
	end,
}
