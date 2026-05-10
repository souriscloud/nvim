-- nvim-surround — manipulate quotes/brackets/tags
--   ys{motion}{char}   — add surround     (e.g. ysiw"   = surround word with ")
--   yss{char}          — surround whole line
--   ds{char}           — delete surround  (e.g. ds"     = remove "")
--   cs{old}{new}       — change surround  (e.g. cs"'    = change " → ')
--   In visual: S{char} — surround selection
return {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({})
	end,
}
