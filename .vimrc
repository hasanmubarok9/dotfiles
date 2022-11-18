syntax on
set autoread
set number
set relativenumber
set ic
set nocompatible
set incsearch
set hls
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set ts=2 " tabstop"
set et " expandtab"
set sts=2 "softtabstop"
set sw=2 "shiftwidth"
set ai " autoindent"
set si " smartindent"
filetype plugin indent on
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'pangloss/vim-javascript'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }
" Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
" post install (yarn install | npm install) then load plugin only for editing
" supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile
			\ --production'  }
Plug 'christoomey/vim-tmux-navigator'
" Elixir
Plug 'elixir-editors/vim-elixir'
call plug#end()
" ---> NERDTree <---
let mapleader = ","
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" ---> to hide unwanted files <---
let NERDTreeIgnore = [ 'node_modules/' ]
" ---> show hidden files <---
let NERDTreeShowHidden=1
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" --> coc <--
"use tab for trigger completion with characters ahead and navigate.
" note: There's always complete item selected by default, you may want to
" enable
" no select by `"suggest.noselect": true` in your configuration file.
" note: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config."
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" nnoremap <silent> K :call ShowDocumentation()<CR>
"
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
   call CocActionAsync('doHover')
  else
   call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)"

" C++ format using clang-format, see clang-format --help
map <C-K> :py3f /opt/homebrew/Cellar/clang-format/14.0.6/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:py3f /opt/homebrew/Cellar/clang-format/14.0.6/share/clang/clang-format.py<cr>

function! Formatonsave()
  let l:formatdiff = 1
  py3f /opt/homebrew/Cellar/clang-format/14.0.6/share/clang/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()

" C++ competitive programming templates
autocmd BufNewFile *.cc,*.cpp 0r ~/.vim/templates/skeleton.cc
" C++ compile and run
nnoremap <C-c> :!clang++ -std=c++11 % -o %:r<CR>

" :term vertical botright term
nnoremap <C-]> :wa<CR>:vertical botright term ++kill=term<CR>

" --> snippets <--
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" --> fuzzy finder <--
silent! nmap <C-P> :Files<CR>
silent! nmap <C-G> :GFiles<CR>
silent! nmap <C-f> :Rg!

" --> colorscheme <--
colorscheme codedark

" --> vim_airline_theme <--
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

" --> autopairs <--
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.vue,*.phtml,*.js,*.jsx,*.coffee,*.erb'
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" --> vim-jsx-pretty <--
let g:vim_jsx_pretty_colorful_config = 1 " default 0"

" Max line length that prettier will wrap on: a number or 'auto' (use
" textwidth).
" default: 'auto'
let g:prettier#config#print_width = 80

" number of spaces per indentation level: a number or 'auto' (use
" softtabstop)
" default: 'auto'
let g:prettier#config#tab_width = 2

" use tabs instead of spaces: true, false, or auto (use the expandtab
" setting).
" default: 'auto'
let g:prettier#config#use_tabs = 'false'

