" ========= Vundle ===========
"
" set the runtime path to include Vundle and initialize
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Bundle "bling/vim-airline"
Bundle "vim-airline/vim-airline-themes"
Plugin 'ctrlp.vim'
Bundle 'Townk/vim-autoclose.git'
Bundle "jiangmiao/auto-pairs"
Bundle "airblade/vim-gitgutter"
Bundle "scrooloose/nerdtree"
Bundle "majutsushi/tagbar"
Bundle 'edkolev/tmuxline.vim'
Plugin 'flazz/vim-colorschemes'
"Bundle 'scrooloose/syntastic.git'

" nvim-cmp
Plugin 'neovim/nvim-lspconfig'
Plugin 'hrsh7th/cmp-nvim-lsp'
Plugin 'hrsh7th/cmp-buffer'
Plugin 'hrsh7th/cmp-path'
Plugin 'hrsh7th/cmp-cmdline'
Plugin 'hrsh7th/nvim-cmp'
Plugin 'onsails/lspkind-nvim'

" For vsnip users.
Plugin 'hrsh7th/cmp-vsnip'
Plugin 'hrsh7th/vim-vsnip'

call vundle#end()            " required

" ========= Vundle end ==========

"-------------------------- gerneral settings -----------------------------
set nocompatible
syntax on
filetype plugin indent on

" silent! colorscheme onedark
colorscheme codedark

set encoding=utf-8

set smartindent
set tabstop=4
set shiftwidth=4
set number
set bufhidden=hide
set expandtab

set omnifunc=syntaxcomplete#Complete
set backspace=indent,eol,start

set laststatus=2
set statusline+=%f%m%r%h\ [%L]\ [%{&ff}]\ %y%=[%p%%]\ [line:%05l,col:%02v]

set cursorline 
hi cursorline term=bold cterm=bold

set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm

set list          
set listchars=tab:•\ ,trail:•,extends:»,precedes:« 

" Keep search matches in the middle of the window.
nnoremap n nzzzv 
nnoremap N Nzzzv

" Custom key map
nmap <CR> o<Esc>
imap [ []<Esc>i

inoremap <C-C> <ESC>


" Completion popup color theme

" dark theme
"hi PmenuSel ctermfg=255 ctermbg=239
"hi Pmenu ctermfg=250 ctermbg=235
"
" light theme
"hi PmenuSel ctermfg=9 ctermbg=215
"hi Pmenu ctermfg=236 ctermbg=223


"--------------- NERDTree -------------
map <C-\> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"---------------- TagBar ---------------
nmap <C-u> :TagbarToggle<CR>

"--------------- airline --------------
let g:airline_powerline_fonts = 0
let g:airline_theme='wombat'
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

"------------- nvim-cmp ----------------
set completeopt=menu,menuone,noselect

lua <<EOF
  local lspkind = require('lspkind')
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({with_text = true, maxwidth = 50})
    },
	experimental = {
	  native_menu = false,
	},
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
	  ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
EOF

" gray
highlight! CmpItemAbbrDeprecated ctermbg=NONE gui=strikethrough ctermfg=244
" blue
highlight! CmpItemAbbrMatch ctermbg=NONE ctermfg=74
highlight! CmpItemAbbrMatchFuzzy ctermbg=NONE ctermfg=74
" light blue
highlight! CmpItemKindVariable ctermbg=NONE ctermfg=153
highlight! CmpItemKindInterface ctermbg=NONE ctermfg=153
highlight! CmpItemKindText ctermbg=NONE ctermfg=153
" pink
highlight! CmpItemKindFunction ctermbg=NONE ctermfg=175
highlight! CmpItemKindMethod ctermbg=NONE ctermfg=175
" front
highlight! CmpItemKindKeyword ctermbg=NONE ctermfg=188
highlight! CmpItemKindProperty ctermbg=NONE ctermfg=188
highlight! CmpItemKindUnit ctermbg=NONE ctermfg=188

" gray
"highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
"" blue
"highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
"highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
"" light blue
"highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
"highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
"highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
"" pink
"highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
"highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
"" front
"highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
"highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
"highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
"


" ---------------------- LSP setup ----------------------
"
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
