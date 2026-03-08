require('config.options')
require('config.keybinds')
require('config.lazy')

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})
