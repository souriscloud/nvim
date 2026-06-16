local M = {}

-- Set keymaps when an LSP attaches to a buffer.
-- Uses Neovim 0.11 built-in LSP UI + Telescope pickers (no lspsaga).
M.on_attach = function(client, bufnr)
  local function map(lhs, rhs, desc, mode)
    vim.keymap.set(mode or "n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  -- Navigation
  map("gd", vim.lsp.buf.definition, "LSP: go to definition")
  map("gD", vim.lsp.buf.declaration, "LSP: go to declaration")
  map("gi", vim.lsp.buf.implementation, "LSP: go to implementation")
  map("gy", vim.lsp.buf.type_definition, "LSP: go to type definition")
  map("gr", "<cmd>Telescope lsp_references<cr>", "LSP: references (Telescope)")
  map("<leader>gs", "<cmd>Telescope lsp_document_symbols<cr>", "LSP: document symbols")
  map("<leader>gS", "<cmd>Telescope lsp_workspace_symbols<cr>", "LSP: workspace symbols")

  -- Info
  map("K", vim.lsp.buf.hover, "LSP: hover docs")
  -- Signature help on gK (blink.cmp also shows it automatically while typing;
  -- insert-mode <C-k> belongs to blink for selecting the previous item).
  map("gK", vim.lsp.buf.signature_help, "LSP: signature help")

  -- Actions
  map("<leader>rn", vim.lsp.buf.rename, "LSP: rename")
  map("<leader>ca", vim.lsp.buf.code_action, "LSP: code action")

  -- Diagnostics
  map("<leader>d", vim.diagnostic.open_float, "Diagnostics: line float")
  map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Diagnostics: prev")
  map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Diagnostics: next")
  map("<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics: Trouble list")
end

M.diagnostic_signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

return M
