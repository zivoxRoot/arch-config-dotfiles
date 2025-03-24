return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	cmd = "Neogit",
	keys = function()
		return {
			{ "<leader>gg", function() require("neogit").open() end, desc = "Open Neogit" },
			{ "<leader>gc", function() require("neogit").open({ "commit" }) end, desc = "Commit" },
		}
	end,
	config = function()
		require("neogit").setup({
			disable_signs = false,
			disable_context_highlighting = false,
			disable_commit_confirmation = false,
			integrations = {
				diffview = true,  -- Enable diffview support (optional, install `sindrets/diffview.nvim`)
				telescope = true, -- Enable Telescope support if installed
			},
		})
	end,
}
