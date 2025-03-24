return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.files").setup({
			mappings = {
				close = "q",        -- Close the explorer
				go_in = "l",        -- Go into a directory
				go_in_plus = "<CR>",-- Go into a directory
				go_out = "h",       -- Go out of a directory
				reset = "<BS>",     -- Reset to root directory
				synchronize = 's',
			},
			options = {
				use_fs_watch = true, -- Auto-update on file system changes
			},
			windows = {
				preview = true,       -- Enable a preview window
				width_focus = 30,     -- Width of focused window
				width_nofocus = 15,   -- Width of non-focused window
			},
		})

		vim.keymap.set("n", "<leader>e", function()
			require("mini.files").open()
		end, { desc = "Open file explorer (mini.files)" })

		vim.keymap.set("n", "<leader>E", function()
			require("mini.files").open(vim.api.nvim_buf_get_name(0))
		end, { desc = "Open file explorer in current file's directory" })
	end,
}
