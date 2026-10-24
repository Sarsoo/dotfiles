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
  -- indent guides
  { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
  -- explorer view, https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  -- neo-tree dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  -- whichkey
  "https://github.com/folke/which-key.nvim",
  -- bracket closing automation
  "https://github.com/m4xshen/autoclose.nvim",
  -- marks ui
  "https://github.com/chentoast/marks.nvim",
  -- better search/jumping
  "https://github.com/folke/flash.nvim",
  -- blink.cmp
  -- {
  --   src = 'https://github.com/saghen/blink.lib',
  --   -- Version constraint, see |vim.version.range()|
  --   version = vim.version.range('1.10'),
  -- },
  {
    src = 'https://github.com/saghen/blink.cmp',
    -- Version constraint, see |vim.version.range()|
    version = vim.version.range('1'),
  }
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

-- indent guides
require("ibl").setup()

require('neo-tree').setup({
  event_handlers = {
    {
      event = "after_render",
      handler = function(state)
        if not require("neo-tree.sources.common.preview").is_active() then
          state.config = { use_float = true }
          state.commands.toggle_preview(state)
        end
      end,
    },
    {
      event = "file_open_requested",
      handler = function()
        -- auto close
        -- vim.cmd("Neotree close")
        -- OR
        require("neo-tree.command").execute({ action = "close" })
      end
    },
  },
})

-- completion sources
local cmp = require('blink.cmp')
-- cmp.build():pwait()
cmp.setup({
  completion = {
    trigger = {
      show_on_backspace = true,
      show_on_backspace_in_keyword = true,
      show_on_insert = true,
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
    },
    ghost_text = {
      enabled = true
    },
    menu = {
      draw = {
        columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
        components = {
          item_idx = {
            text = function(ctx) return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx) end,
            highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
          }
        }
      }
    }
  },
  signature = {
    enabled = true
  },
  keymap = {
    preset = "default",
    ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
    ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
    ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
    ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
    ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
    ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
    ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
    ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
    ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
    ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
  }
})

-- keyboard shortcut guides
require("which-key").setup()

-- bracket closing automation
require("autoclose").setup()

-- marks ui
require("marks").setup()

-- better search/jumping
require("flash").setup({
  search = {
    mode = "fuzzy"
  },
  modes = {
    char = {
      jump_labels = true
    }
  }
})
