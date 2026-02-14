vim.g.mapleader = " "

vim.keymap.set('i', 'jj', '<Esc>')

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

vim.keymap.set('i', '(', '()<Esc>i')
vim.keymap.set('i', '[', '[]<Esc>i')
vim.keymap.set('i', '{', '{}<Esc>i')

vim.keymap.set('n', '<leader>a', ':split | terminal<CR>', { desc = 'Open a termin[a]l' })

vim.keymap.set('n', '<C-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==')

vim.keymap.set('n', '<leader>ep', ':w<CR>:!python %<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('v', "<leader>'", "c''<Esc>P")
vim.keymap.set('v', '<leader>"', 'c""<Esc>P')
vim.keymap.set('v', '<leader>(', 'c()<Esc>P')
vim.keymap.set('v', '<leader>)', 'c()<Esc>P')
vim.keymap.set('v', '<leader>[', 'c[]<Esc>P')
vim.keymap.set('v', '<leader>]', 'c[]<Esc>P')
vim.keymap.set('v', '<leader>{', 'c{}<Esc>P')
vim.keymap.set('v', '<leader>}', 'c{}<Esc>P')

vim.keymap.set('n', '<leader>li', 'i[]()<Left><Left><Left><Esc>a')
vim.keymap.set('v', '<leader>li', '"ac[<C-r>"]()<Esc><Left>a')
vim.keymap.set('n', '<leader>lp', 'i[]()<Left><Esc>pF[a')
vim.keymap.set('v', '<leader>lp', '"ac[<C-r>"]()<Esc><Left>p')

vim.keymap.set('n', '<leader>w', ':write<CR>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>Q', ':q!<CR>', { desc = 'Force Quit' })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.c',
  callback = function()
    vim.keymap.set('n', '<leader>bc', 'i#include <stdio.h><CR><CR>int main() {<CR>}<Esc>O', { buffer = true }, { desc = '[B]oilerplate [C]' })
    end,
})

