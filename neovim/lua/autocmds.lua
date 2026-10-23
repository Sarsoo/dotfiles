-- https://github.com/stevearc/dotfiles/blob/10f8110d16cf22bf33a6b501f2c7de3ecba0f6a5/.config/nvim/init.lua#L293
vim.api.nvim_create_autocmd("FocusGained", {
  desc = "Reload files from disk when we focus vim",
  pattern = "*",
  command = "if getcmdwintype() == '' | checktime | endif",
  group = aug,
})
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Every time we enter an unmodified buffer, check if it changed on disk",
  pattern = "*",
  command = "if &buftype == '' && !&modified && expand('%') != '' | exec 'checktime ' . expand('<abuf>') | endif",
  group = aug,
})


-- https://github.com/den-is/nvim/blob/master/lua/config/autocmds.lua
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Enable spell checking for certain file types",
  pattern = { "*.txt", "*.md" },
  callback = function()
    vim.opt.spell = true
  end,
})

-- https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    -- 2
    vim.api.nvim_create_autocmd("BufWritePre", {
      -- 3
      buffer = args.buf,
      callback = function()
        -- 4 + 5
        vim.lsp.buf.format {async = false, id = args.data.client_id }
      end,
    })
  end
})

