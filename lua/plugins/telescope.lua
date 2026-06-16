local config = function()
  local telescope = require('telescope')
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewer = false,
        hidden = true,
      },
      live_grep = {
        theme = "dropdown",
        previewer = false,
      },
      buffers = {
        theme = "dropdown",
        previewer = false,
      },
    },
  })
  telescope.load_extension("fzf")
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Native fzf sorter (C) — much faster fuzzy matching than the Lua sorter.
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = config,
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Help tags" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>",     desc = "Keymaps" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Recent files" },
    { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
  },
}
