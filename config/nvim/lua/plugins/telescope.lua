return {
	{
		"nvim-telescope/telescope.nvim", tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set('n', '<leader>p', builtin.find_files, {})
			vim.keymap.set('n', '<leader>tg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>f', builtin.current_buffer_fuzzy_find, {}) -- Keybinding to search within the current buffer

			-- Vim like navigation in insert mode
			require("telescope").setup({
				defaults = {
					find_files = {
						hidden = true,
					},
					file_ignore_patterns = {
						"%.git/",  -- Ignore .git directory and all its contents
						"%.gitignore",  -- Optionally ignore .gitignore
					},

					mappings = {
						i = {
							["<M-j>"] = require("telescope.actions").move_selection_next,
							["<M-k>"] = require("telescope.actions").move_selection_previous,
							["<M-d>"] = require("telescope.actions").preview_scrolling_down,
							["<M-u>"] = require("telescope.actions").preview_scrolling_up,
						},
						n = {
							["j"] = require("telescope.actions").move_selection_next,
							["k"] = require("telescope.actions").move_selection_previous,
							["<M-d>"] = require("telescope.actions").preview_scrolling_down,
							["<M-u>"] = require("telescope.actions").preview_scrolling_up,
						}
					}
				},
				pickers = {
					find_files = {
						hidden = true,
					},
					file_ignore_patterns = {
						"%.git/",  -- Ignore .git directory and all its contents
						"%.gitignore",  -- Optionally ignore .gitignore
					},
				},
				extensions = {
					file_browser = {
						hidden = true,
					},
					file_ignore_patterns = {
						"%.git/",  -- Ignore .git directory and all its contents
						"%.gitignore",  -- Optionally ignore .gitignore
					},
				},
			})
		end
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup {
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown {}
					}
				}
			}
			require("telescope").load_extension("ui-select")
		end
	}
}
