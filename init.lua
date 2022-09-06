vim.cmd("source ~/.config/nvim/vimrc")

-- look and feel --
if (vim.env.TMUX == nil) then
	vim.opt.termguicolors = false
else
	vim.opt.termguicolors = true
end
