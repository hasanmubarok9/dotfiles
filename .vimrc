" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Show line numbers
set number

" Set relative numbers
set relativenumber

" Highlight Search
set hls

" Ignore case search
set ignorecase

" Sets the width of a tab to 4 spaces 
set tabstop=4

" Sets the number of spaces used for each step of auto indent
set shiftwidth=4

" Converts tabs to spaces
set expandtab

" Set redrawtime
set redrawtime=1000
" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugins for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn on syntax highlighting on.
syntax on

" Color scheme
colorscheme darkblue

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
call plug#end()

" FZF key bindings
nnoremap <C-p> :FZF<CR>

" Define function for compile and run c++ file, :-)
function! CompileAndRun()
		let l:current = expand('%')       " Get the path of the current file
		let l:output = fnamemodify(l:current, ":p:h") . "/output" " Construct the path for the output file
		let l:input = fnamemodify(l:current, ":p:h") . "/in" " Construct the path for the input file
		
		"Run the compile and run command
		execute "!g++-13 " . l:current . " -o " . l:output . " && " . l:output . " < " . l:input
		" return "the current file is " . l:current . ", the output file is " . l:output . ", and the input file is " .  l:input
		" echo "Test Hasan " . l:current . ", nilai output " . l:output . ", dan nilai input " . l:input
endfunction

" compile and run cpp file key bindings
nnoremap <F5> :call CompileAndRun()<CR>

" cpp templates for competitive programming
autocmd BufNewFile *.cc 0r ~/.vim/templates/cpp_template.cpp
