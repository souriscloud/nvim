return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the noti
    --   if not available we use `mini` as fallback
    {
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup({
          background_colour = "#000000"
        })
      end
    },
  },
}
