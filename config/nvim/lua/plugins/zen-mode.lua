return {
	"folke/zen-mode.nvim",
	config = function()
		require("zen-mode").setup({
			window = {
				backdrop = 1, -- Dim the background
				width = 1, -- Width of the Zen window
				height = 1, -- Height of the Zen window (percentage)
				options = {
					signcolumn = "no", -- Disable sign column
					number = false, -- Disable line numbers
					relativenumber = false, -- Disable relative numbers
					cursorline = false, -- Disable cursorline
					cursorcolumn = false, -- Disable cursorcolumn
					foldcolumn = "0", -- Disable fold column
					list = false, -- Disable whitespace characters
				},
			},
			plugins = {
				twilight = { enabled = true }, -- Enable Twilight integration
				options = {
					enabled = true,
					showcmd = false,
					laststatus = 0,
				},
			},
			on_open = function()
				-- Actions to perform when Zen mode is activated
			end,
			on_close = function()
				-- Actions to perform when Zen mode is deactivated
			end,
		})

		-- Optional: Keymap to toggle Zen Mode
		vim.keymap.set("n", "<leader>zz", ":ZenMode<CR>", { desc = "Toggle Zen Mode" })
	end,
}
