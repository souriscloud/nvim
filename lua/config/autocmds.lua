-- LSP attach: set buffer-local keymaps + per-server hooks
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttachGroup", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- Standard keymaps for any attached server
    require("util.lsp").on_attach(client, args.buf)

    -- Per-server hooks
    if client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        command = "EslintFixAll",
      })
    end
  end,
})

-- Format on save is handled by conform.nvim (see lua/plugins/conform.lua).

-- Auto-open the quickfix window after :grep (so matches are immediately
-- browsable, like Emacs grep-mode).
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = vim.api.nvim_create_augroup("AutoOpenQuickfix", {}),
  pattern = { "grep", "grepadd", "vimgrep", "vimgrepadd" },
  command = "botright cwindow",
})

-- Flash on yank (replaces vim-highlightedyank plugin)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", {}),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})
