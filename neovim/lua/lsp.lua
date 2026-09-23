-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp

vim.lsp.codelens.enable(true)
vim.lsp.inlay_hint.enable(true)
vim.lsp.inline_completion.enable()

-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/bashls.lua
-- https://github.com/bash-lsp/bash-language-server
-- (npm i -g bash-language-server)
vim.lsp.enable('bashls')

-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/csharp_ls.lua
vim.lsp.enable('csharp_ls')

-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/docker_language_server.lua
-- https://github.com/docker/docker-language-server
-- (go install github.com/docker/docker-language-server/cmd/docker-language-server@latest)
vim.lsp.enable('docker_language_server')

-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/helm_ls.lua
-- https://github.com/mrjosh/helm-ls
vim.lsp.enable('helm_ls')

-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/terraformls.lua
-- https://github.com/hashicorp/terraform-ls
vim.lsp.enable('terraformls')
