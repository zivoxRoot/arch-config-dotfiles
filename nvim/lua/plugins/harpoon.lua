return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon").setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
				enter_on_sendcmd = false,
				excluded_filetypes = { "harpoon" },
			},
		})

		-- Harpoon keymaps
		local opts = { noremap = true, silent = true }

		-- Mark the current file
		vim.keymap.set("n", "<Leader>m", function()
			require("harpoon.mark").add_file()
		end, opts)

		-- Open the Harpoon menu
		vim.keymap.set("n", "<Leader>h", function()
			require("harpoon.ui").toggle_quick_menu()
		end, opts)

		-- Navigate between marks
		vim.keymap.set("n", "<Leader>1", function()
			require("harpoon.ui").nav_file(1)
		end, opts)
		vim.keymap.set("n", "<Leader>2", function()
			require("harpoon.ui").nav_file(2)
		end, opts)
		vim.keymap.set("n", "<Leader>3", function()
			require("harpoon.ui").nav_file(3)
		end, opts)
		vim.keymap.set("n", "<Leader>4", function()
			require("harpoon.ui").nav_file(4)
		end, opts)
		vim.keymap.set("n", "<Leader>5", function()
			require("harpoon.ui").nav_file(5)
		end, opts)

	end,
}
