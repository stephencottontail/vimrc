vim.api.nvim_buf_set_keymap(0, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

require'lspconfig'.tsserver.setup{}
