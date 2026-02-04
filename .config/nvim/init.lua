vim.env.PATH = '/opt/homebrew/bin:' .. vim.env.PATH
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.have_nerd_font = true

require 'config.keymaps'
require 'config.autocmds'
require 'config.lazy'
require 'config.options'
require 'custom.floaterminal'
