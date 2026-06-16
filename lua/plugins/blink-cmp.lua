-- blink.cmp — completion engine (replaces nvim-cmp + cmp-* + lspkind + luasnip).
-- Rust fuzzy matcher, batteries included, far less config than the cmp stack.
-- Loaded eagerly as a dependency of nvim-lspconfig so LSP capabilities are
-- registered before any server attaches.
return {
	"saghen/blink.cmp",
	version = "*", -- release tag → downloads the prebuilt fuzzy binary
	dependencies = {
		"rafamadriz/friendly-snippets",
		"folke/lazydev.nvim",
	},
	opts = {
		-- Preserve the old C-j / C-k navigation muscle memory (also used in
		-- Telescope). C-k is no longer overloaded with signature help — the
		-- signature window below shows automatically instead.
		keymap = {
			preset = "none",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},
		appearance = { nerd_font_variant = "mono" },
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 200 },
			menu = { draw = { treesitter = { "lsp" } } },
		},
		signature = { enabled = true },
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "lazydev" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
