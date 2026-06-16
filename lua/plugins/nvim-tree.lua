return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen", "NvimTreeFindFile" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    filters = {
      dotfiles = false,
    },
    view = {
      width = 35,
    },
    renderer = {
      group_empty = true,
    },
  },
}
