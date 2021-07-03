" Install plugins as first thing
source ~/vimrc/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('~/vimrc/{}')

" Appearance
set encoding=utf-8
set guifont=New-Heterodox-Mono.otf:h18
set laststatus=2
colorscheme darknord

" Global keybindings
let mapleader = ' '
inoremap kj <Esc>
vnoremap kj <Esc>
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wl <C-w>l

function! SynStack()
	if !exists("*synstack")
		return
	endif
	let l:s = synID(line('.'), col('.'), 1)  
	echo synIDattr(synIDtrans(l:s), 'name') . ' -> ' . synIDattr(l:s, 'name') 
endfunc
nnoremap <Leader>s :call SynStack()<CR>
