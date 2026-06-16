local config = function()
	require("lualine").setup({
		options = {
			theme = "nightfox",
			globalstatus = true,
		},
		sections = {
			lualine_a = { "mode" },
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = config,
}
