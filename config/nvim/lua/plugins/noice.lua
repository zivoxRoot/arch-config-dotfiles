return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("notify").setup({
      background_colour = "#1e1e2e", -- Change this to your preferred background color
    })

    require("noice").setup({
      routes = {
        {
          filter = {
            event = "msg_show",
            find = "written",
          },
          opts = { skip = true },
        },
      },
    })

    vim.notify = require("notify")
  end,
}
