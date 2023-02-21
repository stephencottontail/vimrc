" Install plugins as first thing
if has('iVim')
	source ~/vimrc/vim-pathogen/autoload/pathogen.vim
	execute pathogen#infect('~/vimrc/{}')
endif

if has('nvim')
	source ~/.config/nvim/vim-pathogen/autoload/pathogen.vim
	execute pathogen#infect('~/.config/nvim/{}')
endif

" Look and feel
set encoding=utf-8
set guifont=New-Heterodox-Mono.otf:h18
set laststatus=2
set tabstop=4
set shiftwidth=4
set wildignore+=*/node_modules/*
set path+=src/**,test/**
set nohidden
set notermguicolors
colorscheme fourbit

" Global keybindings
let mapleader = ' '
inoremap kj <Esc>
vnoremap kj <Esc>
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wl <C-w>l
tnoremap kj <C-\><C-n>
tnoremap <Esc> <C-\><C-n>

function! SynStack()
	if !exists("*synstack")
		return
	endif
	let l:s = synID(line('.'), col('.'), 1)  
	echo synIDattr(synIDtrans(l:s), 'name') . ' -> ' . synIDattr(l:s, 'name') 
endfunc
nnoremap <Leader>S :call SynStack()<CR>

" Implement copy-paste between neovim on Pi and iPad
augroup oscyank
	autocmd!
	autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankReg +' | endif
augroup END

set clipboard& clipboard^=unnamed,unnamedplus

" Neovim Lua config
if has('nvim')
	set runtimepath+=~/.config/vimrc

	function! LSP() abort
		lua require'lsp'
	endfunc
	augroup lsp
		au!
		autocmd BufReadPost *.js,*.jsx,*.ts,*.tsx,*.php call LSP()
		autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx lua vim.lsp.buf.format( { timeout_ms = 500000 } );
	augroup END

	lua require'gitsigns'
	"lua require'treesitter'
endif
