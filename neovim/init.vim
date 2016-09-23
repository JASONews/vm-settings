" ========= Vundle ===========
" set the runtime path to include Vundle and initialize
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'neocomplcache'
Bundle "bling/vim-airline"
Bundle "vim-airline/vim-airline-themes"
Plugin 'ctrlp.vim'
Bundle 'Townk/vim-autoclose.git'
Bundle "jiangmiao/auto-pairs"
Bundle "airblade/vim-gitgutter"
Bundle "tpope/vim-fugitive"
Bundle "scrooloose/nerdtree"
Bundle "majutsushi/tagbar"
Bundle 'scrooloose/syntastic.git'
Bundle 'edkolev/tmuxline.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'easytags.vim'
Plugin 'xolox/vim-misc'
call vundle#end()            " required

" ========= Vundle end ==========

"-------------------------- gerneral settings -----------------------------
set nocompatible
syntax on
filetype plugin indent on

colorscheme onedark
set smartindent
set tabstop=4
set shiftwidth=4
set number
set bufhidden=hide

set laststatus=2
set statusline+=%f%m%r%h\ [%L]\ [%{&ff}]\ %y%=[%p%%]\ [line:%05l,col:%02v]

set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm

set list          
set listchars=tab:•\ ,trail:•,extends:»,precedes:« 

" Keep search matches in the middle of the window.
nnoremap n nzzzv 
nnoremap N Nzzzv


"--------------- NERDTree -------------
map <C-\> :NERDTreeToggle<CR>

"---------------- TagBar ---------------
nmap <C-u> :TagbarToggle<CR>

"--------------- EasyTags -------------
let g:easytags_autorecurse = 1
let g:easytags_async = 1

"--------------- airline --------------
let g:airline_powerline_fonts = 1
let g:airline_theme='hybrid'
let g:airline#extensions#tabline#enabled = 0
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ }

 let g:airline_skip_empty_sections = 1

 if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

let g:airline#extensions#virtualenv#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#non_zero_only= 1  
let g:airline#extensions#tmuxline#enabled = 0

"-------------  neoComplete ---------------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 1
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }
		
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 0
	
set completeopt-=preview
" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"
" ======== neocomplete end ========

set smartindent
set tabstop=4
set omnifunc=syntaxcomplete#Complete

nmap <CR> o<Esc>
imap [ []<Esc>i

"hi Pmenu ctermfg=0 ctermbg=223
hi PmenuSel ctermfg=255 ctermbg=75
hi Pmenu ctermfg=253 ctermbg=68

" dark theme
hi PmenuSel ctermfg=255 ctermbg=239
hi Pmenu ctermfg=250 ctermbg=235

" light theme
"hi PmenuSel ctermfg=9 ctermbg=215
"hi Pmenu ctermfg=236 ctermbg=223

set backspace=indent,eol,start
