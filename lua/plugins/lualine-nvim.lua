local function lsp_names()
	local names = {}
	for _, c in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
		names[#names + 1] = c.name
	end
	return #names > 0 and ("  " .. table.concat(names, ",")) or ""
end

local config = function()
	require("lualine").setup({
		options = {
			theme = "catppuccin",
			globalstatus = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { lsp_names, "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = config,
}
