return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Global LSP keybindings
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<space>f", function()
				vim.lsp.buf.format({ async = true })
			end, opts)
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")

			-- lspconfig.rust_analyzer.setup {
			-- 	-- Server-specific settings. See `:help lspconfig-setup`
			-- 	settings = {
			-- 		['rust-analyzer'] = {},
			-- 	},
			-- }

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Install gopls using Mason
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					if server_name == "gopls" then
						lspconfig.gopls.setup({
							capabilities = capabilities,
							settings = {
								gopls = {
									analyses = {
										unusedparams = true,
									},
								-- 	staticcheck = true,
								-- 	gofumpt = true,
								},
							},
						})
					end
				end,
			})

			-- Install additional Go tools
			require("mason-lspconfig").setup({
				-- ensure_installed = { "gopls", "gofumpt", "goimports" },
				ensure_installed = { "gopls" },
			})
		end,
	}
}
