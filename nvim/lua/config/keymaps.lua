-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here

-- Drop LazyVim's move-line bindings. Wrapped in pcall so a rename upstream
-- cannot break startup.
for _, lhs in ipairs({ "<A-j>", "<A-k>" }) do
  pcall(vim.keymap.del, { "n", "i", "v" }, lhs)
end

-- Toggle blink.cmp and copilot
local autocomplete_disabled = false
local copilot_enabled = true

local function toggle_both()
  autocomplete_disabled = not autocomplete_disabled
  
  if autocomplete_disabled then
    -- Disable blink.cmp
    local ok, blink = pcall(require, "blink.cmp")
    if ok then
      blink.show(false)
    end
    
    vim.notify("Autocomplete DISABLED")
  else
    -- Re-enable blink.cmp
    local ok, blink = pcall(require, "blink.cmp")
    if ok then
      blink.show(true)
    end
    
    vim.notify("Autocomplete ENABLED")
  end
  
  -- Toggle copilot
  copilot_enabled = not copilot_enabled
  vim.cmd("Copilot " .. (copilot_enabled and "enable" or "disable"))
end

vim.keymap.set("n", "<leader>tc", toggle_both, { noremap = true, silent = false, desc = "Toggle Copilot & Autocomplete" })

-- Toggle pyright inline diagnostics (virtual text)
local diagnostics_enabled = true
vim.keymap.set("n", "<leader>td", function()
  diagnostics_enabled = not diagnostics_enabled
  vim.diagnostic.config({ virtual_text = diagnostics_enabled })
  vim.notify("Diagnostics virtual text " .. (diagnostics_enabled and "ENABLED" or "DISABLED"))
end, { noremap = true, silent = false, desc = "Toggle Diagnostics Virtual Text" })
