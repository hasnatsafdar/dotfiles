-- local function enable_transparency()
--     vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
-- end
-- return {
--     {
-- 	"folke/tokyonight.nvim",
-- 	config = function()
-- 	    vim.cmd.colorscheme "tokyonight"
-- 	    enable_transparency()
-- 	end
--     },
--     {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = {
-- 	    "nvim-tree/nvim-web-devicons",
-- 	},
-- 	opts = {
-- 	    themes = 'tokyonight',
-- 	}
--     },
-- }

local function enable_transparency()
  local groups = {
    "Normal",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "EndOfBuffer",
    "StatusLine",
    "MsgArea",
    "WinSeparator",
    "Pmenu",
    "PmenuSel",
    "PmenuSbar",
    "PmenuThumb",
    "NoiceCmdlinePopup",
    "NoiceCmdlinePopupBorder",
    "NoicePopup",
    "NoicePopupBorder",
  }

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        transparent = true,
      })

      vim.cmd.colorscheme("tokyonight")
      enable_transparency()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        theme = "tokyonight",
        component_separators = "",
        section_separators = "",
      },
    },
  },
}
