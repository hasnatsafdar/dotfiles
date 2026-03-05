return {
  "stevearc/oil.nvim",
  dependencies = {
    { "echasnovski/mini.icons", lazy = false },
    { "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    local oil = require("oil")
    oil.setup({
      float = {
        border = "rounded",      -- adds a rounded border
        max_width = 0.8,         -- optional: max width as fraction of screen
        max_height = 0.8,        -- optional: max height as fraction of screen
        win_options = {
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
        },
      },
    })

    -- keymap
    vim.keymap.set("n", "<leader>cd", oil.toggle_float, {})

    -- optional: give Oil's float a subtle background to match Tokyonight
    vim.api.nvim_set_hl(0, "OilNormal", { bg = "#1a1b26" })
    vim.api.nvim_set_hl(0, "OilBorder", { fg = "#7aa2f7", bg = "#1a1b26" })
  end,
  lazy = false,
}
