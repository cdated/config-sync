-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.relativenumber = false -- Relative line numbers
opt.mouse = ""
vim.opt.statuscolumn = ""
vim.opt.signcolumn = "number"
vim.opt.swapfile = false
vim.cmd([[hi SignColumn guibg=#151515]])
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
