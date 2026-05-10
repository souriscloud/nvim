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

-- Format on save via efm-langserver
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LspFormattingGroup", {}),
  callback = function(args)
    local efm = vim.lsp.get_clients({ bufnr = args.buf, name = "efm" })
    if vim.tbl_isempty(efm) then
      return
    end
    vim.lsp.buf.format({ name = "efm", async = true })
  end,
})

-- Flash on yank (replaces vim-highlightedyank plugin)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", {}),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})
