-- auto-format on save (via efm-langserver)
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = lsp_fmt_group,
  callback = function(args)
    local efm = vim.lsp.get_clients({ bufnr = args.buf, name = "efm" })
    if vim.tbl_isempty(efm) then
      return
    end
    vim.lsp.buf.format({ name = "efm", async = true })
  end,
})

-- flash on yank (replaces vim-highlightedyank plugin)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", {}),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})
