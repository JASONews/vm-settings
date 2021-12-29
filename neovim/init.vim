" --------- Vim-Plug -------------

call plug#begin('~/.vim/extensions')

Plug 'VundleVim/Vundle.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Townk/vim-autoclose'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'edkolev/tmuxline.vim'
Plug 'flazz/vim-colorschemes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'rmagatti/goto-preview'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'

" nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'


call plug#end()

"-------------------------- gerneral settings -----------------------------
set nocompatible
syntax on
filetype plugin indent on

let &background=$TERM_BG_COLOR

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

set cursorline 
hi cursorline term=bold cterm=bold

" Exit terminal mode
tnoremap <Esc> <C-\><C-n>

"set t_Co=256
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm

set list
set listchars=tab:•\ ,trail:•,extends:»,precedes:« 

" Keep search matches in the middle of the window.
nnoremap n nzzzv 
nnoremap N Nzzzv

" Custom key map
nmap <CR> o<Esc>
imap [ []<Esc>i

" Remember last edit position
autocmd BufRead * autocmd FileType <buffer> ++once
  \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif

inoremap <C-C> <ESC>


"--------------- NERDTree -------------
map <C-\> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"---------------- TagBar ---------------
nmap <C-u> :TagbarToggle<CR>

"--------------- Airline --------------
let g:airline_powerline_fonts = 1
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

let g:airline#extensions#virtualenv#enabled = 1
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
	  native_menu = true,
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

if &background == 'light'

    colorscheme Atelier_SavannaLight
    let g:airline_theme='papercolor'

    " floatin window color
    hi PmenuSel ctermbg=33 ctermfg=255
    hi Pmenu ctermbg=7

    highlight! CmpItemMenu ctermbg=NONE ctermfg=255
    " gray
    highlight! CmpItemAbbrDeprecated ctermbg=NONE gui=strikethrough ctermfg=244
    " blue
    highlight! CmpItemAbbrMatch ctermbg=NONE ctermfg=39 cterm=bold
    highlight! CmpItemAbbrMatchFuzzy ctermbg=NONE ctermfg=39 cterm=bold
    " dark blue
    highlight! CmpItemKindVariable ctermbg=NONE ctermfg=8
    highlight! CmpItemKindInterface ctermbg=NONE ctermfg=8
    highlight! CmpItemKindText ctermbg=NONE ctermfg=8
    " pink
    highlight! CmpItemKindFunction ctermbg=NONE ctermfg=175
    highlight! CmpItemKindMethod ctermbg=NONE ctermfg=175
    " front
    highlight! CmpItemKindKeyword ctermbg=NONE ctermfg=188
    highlight! CmpItemKindProperty ctermbg=NONE ctermfg=188
    highlight! CmpItemKindUnit ctermbg=NONE ctermfg=188

else

    colorscheme Atelier_SavannaDark
    let g:airline_theme='wombat'

    " floatin window color
    hi PmenuSel ctermbg=33 ctermfg=255
    hi Pmenu ctermfg=250 ctermbg=235

    highlight! CmpItemMenu ctermbg=None ctermfg=None
    " gray
    highlight! CmpItemAbbrDeprecated ctermbg=NONE gui=strikethrough ctermfg=244
    " blue
    highlight! CmpItemAbbrMatch ctermbg=NONE ctermfg=39 cterm=bold
    highlight! CmpItemAbbrMatchFuzzy ctermbg=NONE ctermfg=39 cterm=bold
    "highlight! CmpItemAbbrMatch ctermbg=NONE ctermfg=74
    "highlight! CmpItemAbbrMatchFuzzy ctermbg=NONE ctermfg=74
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
endif

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
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

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

"---------------- Modern Cpp hight --------------------
" Enable highlighting of C++11 attributes
"let g:cpp_attributes_highlight = 1
"
"" Highlight struct/class member variables (affects both C and C++ files)
"let g:cpp_member_highlight = 1
"
"" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
"" (affects both C and C++ files)
"let g:cpp_simple_highlight = 1



"--------------- Enhanced Cpp highlight ---------------
"let g:cpp_class_decl_highlight = 1
"let g:cpp_member_variable_highlight = 1
"let g:cpp_concepts_highlight = 1
"let g:cpp_posix_standard = 1
"let g:cpp_class_scope_highlight = 1
"let g:cpp_experimental_template_highlight = 0
"let g:cpp_experimental_simple_template_highlight = 0

"--------------- Telescope ---------------------------
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua << EOF
require('telescope').setup{
  defaults = {
    -- Default configurationfor telescope goes here:
    -- config_key = value,
    mappings = {
        n = {
        -- ["<C-p>"] = "builtin.find_files"
      },
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

EOF



"-------------- tree sitter -------------------------
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

"----------------- GOTO-Preview ------------------------
nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
"" Only set if you have telescope installed
nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>

lua << EOF
require('goto-preview').setup {
  width = 120; -- Width of the floating window
  height = 15; -- Height of the floating window
  border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}; -- Border characters of the floating window
  default_mappings = false; -- Bind default mappings
  debug = false; -- Print debug information
  opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
  resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
  post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
  references = { -- Configure the telescope UI for slowing the references cycling window.
    telescope = require('telescope.themes').get_dropdown({ hide_preview = false })
  };
  -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
  focus_on_open = false; -- Focus the floating window when opening it.
  dismiss_on_move = true; -- Dismiss the floating window when moving the cursor.
  force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
  bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
}
EOF

