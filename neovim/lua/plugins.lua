
vim.pack.add {
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim'
}

require('fzf-lua').setup({'fzf-native'})
require('mini.icons').setup({})
-- require('mini.map').setup({})
require('lualine').setup()
