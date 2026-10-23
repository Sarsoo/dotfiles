local keymap = vim.keymap.set

-- show fzf
keymap("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Show fzf" })

-- show neotree
keymap("n", "<leader>e", "<cmd>Neotree focus filesystem left<cr>", { desc = "Toggle neotree" })
keymap("n", "<leader>b", "<cmd>Neotree focus buffers left<cr>", { desc = "Toggle neotree buffers" })
keymap("n", "<leader>g", "<cmd>Neotree focus git_status right<cr>", { desc = "Show neotree git status" })

-- https://github.com/den-is/nvim/blob/master/lua/config/keymaps.lua
-- Window management
keymap("n", "<leader>\\", "<CMD>vsplit<CR>", { desc = "Split window vertically" })
keymap("n", "<leader>-", "<CMD>split<CR>", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<CMD>close<CR>", { desc = "Close current split" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap("n", "<leader><Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<leader><Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<leader><Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<leader><Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
