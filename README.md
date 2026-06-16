# Neovim configuration

A lazy.nvim-based config for Neovim **0.11+**, using the native `vim.lsp` API
(`vim.lsp.config` / `vim.lsp.enable`), blink.cmp completion, and conform.nvim +
nvim-lint for formatting/linting.

## Layout

```
init.lua                 → require('config')
lua/config/
  init.lua               → bootstraps lazy.nvim + loads the modules below
  globals.lua            → leader, filetype rules, provider toggles, node PATH
  options.lua            → vim.opt settings
  keymaps.lua            → global (non-plugin) keymaps
  autocmds.lua           → LspAttach keymaps, eslint-on-save, yank highlight
lua/plugins/*.lua        → one file per plugin (auto-imported by lazy)
lua/util/lsp.lua         → shared LSP on_attach keymaps + diagnostic signs
```

## Environment / external tools

- Neovim ≥ 0.12 (nvim-treesitter `main` branch requires it)
- git, ripgrep, a C compiler, `make` (telescope-fzf-native)
- `tree-sitter-cli` ≥ 0.25 (`brew install tree-sitter-cli`) — needed to build
  parsers generated from grammar.js (e.g. Swift, Blade). Must be able to emit
  ABI 15; do NOT shadow it with an older npm `tree-sitter-cli` on PATH.
- A Nerd Font (icons)
- Node (LSP/formatters) — pinned to nvm's latest v24 in `config/globals.lua`
- Language toolchains you use: Go, Zig, Swift (`sourcekit-lsp` ships with Xcode),
  Python, PHP
- tmux (optional) for vim-tmux-navigator

LSP servers and formatters/linters are installed automatically by Mason
(`:Mason` to inspect). `sourcekit` (Swift) is the exception — it comes from the
Swift/Xcode toolchain, not Mason.

## Languages

| Language            | LSP                              | Format / Lint                |
|---------------------|----------------------------------|------------------------------|
| Lua                 | lua_ls (+ lazydev)               | stylua / selene              |
| TS/JS/React         | ts_ls, eslint                    | prettierd / eslint           |
| Tailwind / HTML/CSS | tailwindcss, html                | prettierd                    |
| JSON / YAML         | jsonls, yamlls                   | prettierd                    |
| Markdown            | marksman                         | prettierd                    |
| Python              | basedpyright                     | ruff (format + lint)         |
| PHP / Blade         | intelephense                     | blade-formatter              |
| Docker              | dockerls, docker_compose_ls      | hadolint                     |
| Bash                | bashls (+ shellcheck)            | shellcheck                   |
| Go                  | gopls                            | gofumpt + goimports          |
| Zig                 | zls                              | zig fmt                      |
| Swift               | sourcekit                        | swiftformat                  |
| Odin                | ols                              | ols (LSP)                    |
| Jai                 | — (no LSP exists)                | — (filetype only)            |

Treesitter highlighting is enabled for all of the above except Jai (no parser).
nvim-treesitter runs the rewritten `main` branch: parsers install to
`stdpath('data')/site/parser/` via `require('nvim-treesitter').install(...)`,
highlighting starts from a `FileType` autocmd, and the community Blade parser is
registered in `lua/plugins/nvim-treesitter.lua`. Incremental selection is gone
upstream (no replacement).

## Key plugins

- **lazy.nvim** — plugin manager
- **blink.cmp** — completion (Rust matcher; replaced nvim-cmp)
- **nvim-lspconfig** + **mason** / **mason-lspconfig** — LSP
- **conform.nvim** — formatting (format-on-save)
- **nvim-lint** — linting
- **nvim-treesitter** (+ textobjects, ts-autotag) — syntax/indent/text objects
- **telescope** (+ fzf-native) — fuzzy finder
- **oil.nvim** + **nvim-tree** — filesystem-as-buffer + sidebar tree
- **flash.nvim** — jump-anywhere motions
- **nvim-surround**, **Comment.nvim** — editing
- **gitsigns**, **trouble**, **vim-illuminate**, **indent-blankline**
- **lualine** (statusline), **nightfox** (colorscheme), **noice** (cmdline UI)
- **which-key** — keymap hints
- **vim-tmux-navigator** — `<C-hjkl>` across nvim splits + tmux panes

## Keymaps (leader = `Space`)

| Key | Action |
|-----|--------|
| `<leader>e` / `<leader>E` | nvim-tree toggle / focus |
| `-` / `<leader>-` | oil parent dir / floating |
| `<leader>ff` `<leader>fg` `<leader>fb` | find files / live grep / buffers |
| `<leader>fr` `<leader>fh` `<leader>fk` `<leader>/` | recent / help / keymaps / in-buffer |
| `<leader>sv` `<leader>sh` | vertical / horizontal split |
| `<leader>bd` `[b` `]b` | delete buffer / prev / next |
| `s` `S` `r` `R` | flash jump / treesitter / remote / search |
| `gd` `gD` `gi` `gy` `gr` | LSP definition / declaration / impl / type / references |
| `K` `gK` | hover / signature help |
| `<leader>rn` `<leader>ca` | LSP rename / code action |
| `<leader>d` `[d` `]d` `<leader>xx` | diagnostics float / prev / next / Trouble |
| `<leader>gs` `<leader>gS` | document / workspace symbols |
| `<leader>cf` | format buffer / selection (conform) |
| `<leader>tf` | toggle format-on-save (`:FormatToggle[!]`) |

Completion (insert): `<C-j>`/`<C-k>` next/prev · `<C-Space>` open · `<CR>` accept ·
`<C-b>`/`<C-f>` scroll docs · `<Tab>`/`<S-Tab>` snippet jump.
