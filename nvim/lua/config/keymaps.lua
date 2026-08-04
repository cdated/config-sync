-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here

-- Drop LazyVim's move-line bindings. Wrapped in pcall so a rename upstream
-- cannot break startup.
for _, lhs in ipairs({ "<A-j>", "<A-k>" }) do
  pcall(vim.keymap.del, { "n", "i", "v" }, lhs)
end
