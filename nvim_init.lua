-- ~/.config/nvim/init.lua
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.o.clipboard = 'unnamedplus'

-- lazy.vim is the package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim
require("lazy").setup({
  {
    "melbaldove/llm.nvim",
    dependencies = { "nvim-neotest/nvim-nio" }
  },
  {
    "keith/swift.vim"
  },
  {
    'numToStr/Comment.nvim',
    lazy=false
  }
})

require('Comment').setup()

-- Set leader key to space
vim.g.mapleader = " "

-- Basic keymaps
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')

-- Tab navigation keymaps
vim.api.nvim_set_keymap('n', 'tn', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tp', ':tabprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'to', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true })

-- yank to system clipboard
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Y', '"+Y', { noremap = true, silent = true })



-- Keybindings for llm.nvim functions
vim.keymap.set("n", "<leader>m", function() require("llm").create_llm_md() end)

-- Keybinds for prompting with openai
vim.keymap.set("n", "<leader>g,", function() require("llm").prompt({ replace = false, service = "openai" }) end)
vim.keymap.set("v", "<leader>g,", function() require("llm").prompt({ replace = false, service = "openai" }) end)
vim.keymap.set("v", "<leader>g.", function() require("llm").prompt({ replace = true, service = "openai" }) end)

-- Config to autodetect swift files
vim.cmd([[autocmd BufRead,BufNewFile *.swift set filetype=swift]])

vim.cmd([[colorscheme desert]])
vim.cmd('syntax enable')
vim.cmd('syntax on')
