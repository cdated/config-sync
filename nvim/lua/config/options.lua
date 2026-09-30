-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.relativenumber = false
opt.mouse = ""
opt.statuscolumn = ""
opt.signcolumn = "number"
opt.swapfile = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.textwidth = 120
opt.clipboard = "unnamedplus"
vim.g.autoformat = false

-- Keep the sign column matching the gruvbox hard background. This has to run on
-- ColorScheme: setting it here directly is undone as soon as a scheme loads.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("user_signcolumn", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "#060606" })
  end,
})

-- Format selection to 80 columns
vim.keymap.set("v", "<leader>gq", "gq", { desc = "Format selection" })

-- Set textwidth for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})
