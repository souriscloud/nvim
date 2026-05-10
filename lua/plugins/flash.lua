-- flash.nvim — jump anywhere visible with a 2-char label
-- Usage:
--   s{char}{char}        — jump (normal/visual/operator-pending)
--   S                    — Treesitter node selection
--   r                    — remote flash (in operator-pending: y r {label} ip)
--   R                    — Treesitter search
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		{ "r", mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
		{ "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		{ "<c-s>", mode = { "c" },       function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}
