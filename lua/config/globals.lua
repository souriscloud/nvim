vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Filetype rules — register early so LSPs see them at config time
vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})

-- Disable language host providers we don't use (silences checkhealth noise)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

-- Force Node 24 from nvm (latest v24.* dir), regardless of what the
-- launching shell had active. Falls through silently if not installed.
do
  local nvm_dir = vim.env.NVM_DIR or vim.fn.expand("~/.nvm")
  local matches = vim.fn.glob(nvm_dir .. "/versions/node/v24*/bin", false, true)
  if #matches > 0 then
    table.sort(matches) -- ensures the highest v24.x comes last
    vim.env.PATH = matches[#matches] .. ":" .. vim.env.PATH
  end
end
