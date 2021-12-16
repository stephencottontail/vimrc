vim.api.nvim_set_keymap( 'n', '<Leader>s', '<cmd>lua require\'nvim-treesitter-playground.hl-info\'.show_hl_captures()<cr>', {noremap = true})

require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true
	}
}
