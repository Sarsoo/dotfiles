vim.pack.add {
  { src = "https://github.com/catppuccin/nvim",    name = "catppuccin" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  -- lsp configs, https://github.com/neovim/nvim-lspconfig/tree/master/lsp
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  -- highlight other uses of symbols
  { src = 'https://github.com/RRethy/vim-illuminate' },
}

-- fuzzy finder
require('fzf-lua').setup({ 'fzf-native' })

-- icon provider
require('mini.icons').setup({})

-- require('mini.map').setup({})

-- status line at the bottom
require('lualine').setup()

-- git integration with gutters
require('gitsigns').setup()
