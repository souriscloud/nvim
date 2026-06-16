-- nvim-treesitter-textobjects — rewritten "main" branch.
-- Keymaps are defined by hand now (the plugin no longer wires them):
--   vif / vaf   — inner / around function       via / vaa — argument
--   vic / vac   — inner / around class           vil / val — loop
--   vii / vai   — inner / around conditional
--   ]f [f ]c [c ]a [a — move between nodes
--   <leader>sa / <leader>sA — swap parameter with next / prev
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
				include_surrounding_whitespace = false,
			},
			move = {
				set_jumps = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")

		-- select
		local sel = {
			af = "@function.outer",
			["if"] = "@function.inner",
			ac = "@class.outer",
			ic = "@class.inner",
			aa = "@parameter.outer",
			ia = "@parameter.inner",
			al = "@loop.outer",
			il = "@loop.inner",
			ai = "@conditional.outer",
			ii = "@conditional.inner",
		}
		for lhs, capture in pairs(sel) do
			vim.keymap.set({ "x", "o" }, lhs, function()
				select.select_textobject(capture, "textobjects")
			end, { desc = "Select " .. capture })
		end

		-- move (next/prev start)
		local goto_next = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" }
		local goto_prev = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" }
		for lhs, capture in pairs(goto_next) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move.goto_next_start(capture, "textobjects")
			end, { desc = "Next " .. capture })
		end
		for lhs, capture in pairs(goto_prev) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move.goto_previous_start(capture, "textobjects")
			end, { desc = "Prev " .. capture })
		end

		-- swap
		vim.keymap.set("n", "<leader>sa", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "Swap param with next" })
		vim.keymap.set("n", "<leader>sA", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "Swap param with prev" })
	end,
}
