return {
	'saghen/blink.cmp',
	dependencies = {
		"hrsh7th/nvim-cmp",          -- Autocompletion engine
		"hrsh7th/cmp-nvim-lsp",      -- LSP source for nvim-cmp
		"hrsh7th/cmp-buffer",        -- Buffer source for nvim-cmp
		"hrsh7th/cmp-path",          -- Path source for nvim-cmp
		"hrsh7th/cmp-cmdline",       -- Command line source for nvim-cmp
		"L3MON4D3/LuaSnip",          -- Snippet engine
		"saadparwaiz1/cmp_luasnip",  -- Snippets source for nvim-cmp
	},
	opts = {
		keymap = {
			preset = 'default',

			['<M-k>'] = { 'select_prev', 'fallback' },
			['<M-j>'] = { 'select_next', 'fallback' },
			['<M-l>'] = { 'accept', 'fallback' },

			-- disable a keymap from the preset
			['<M-e>'] = {},

			-- show with a list of providers
			['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
		}
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
		})
	end,
}
