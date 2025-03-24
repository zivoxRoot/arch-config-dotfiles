return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "lua", "c_sharp", "gitcommit", "gitignore", "python", "toml", "rust", "go" },
			hightlight = { enable = true },
			indent = { enable = true },
		})
	end
}
