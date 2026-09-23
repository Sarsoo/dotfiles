vim.cmd [[set completeopt+=menuone,noselect,popup]]

-- set values for how diagnostics are shown
vim.diagnostic.config({
  virtual_text = true,     -- show inline messages
  signs = true,            -- show signs in the gutter
  underline = true,        -- underline problematic text
  update_in_insert = true, -- don't update diagnostics while typing
  severity_sort = true,    -- sort diagnostics by severity
})

-- show window for diagnostics
vim.keymap.set("n", "<Leader>ds", vim.diagnostic.open_float, { desc = "Show diagnostic" })


local virtual_text_enabled = true

vim.keymap.set("n", "<leader>dv", function()
  vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle diagnostics virtual text" })
