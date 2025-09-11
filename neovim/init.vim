" --------- Vim-Plug -------------

call plug#begin('~/.vim/extensions')

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
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'junegunn/vim-easy-align'

Plug 'JASONews/glow-hover'

"Plug 'ctrlpvim/ctrlp.vim'

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

"Plug 'scalameta/nvim-metals'


call plug#end()


"-------------------------- gerneral settings -----------------------------
set nocompatible
syntax on
filetype plugin indent on

" let &background=$TERM_BG_COLOR
if has('nvim')
  set background=light
endif
set encoding=utf-8
set smartindent
set tabstop=2
set shiftwidth=2
set number
set bufhidden=hide
set expandtab

set omnifunc=syntaxcomplete#Complete
set backspace=indent,eol,start
"set cinoptions=:0,l1,t0,g0,(0

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

"---------------- Ctrl-P ---------------
"--------------- airline --------------
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

EOF

if &background == 'light'

    colorscheme Atelier_SavannaLight
    let g:airline_theme='papercolor'

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

    "colorscheme one-dark
    let g:airline_theme='wombat'

    "hi! HoverFloatBorder ctermbg=black ctermfg=green

    hi PmenuSel ctermbg=33 ctermfg=255
    "hi PmenuSel ctermfg=255 ctermbg=239
    hi Pmenu ctermfg=250 ctermbg=235
    "pink 
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
    colorscheme Atelier_SavannaDark
endif


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

  if client.name == 'clangd' then 
      buf_set_keymap('n', '<leader>s', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
  end

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
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['clangd'].setup {
--     capabilities = capabilities
-- }
-- require('lspconfig')['pyright'].setup {
--     capabilities = capabilities
-- }

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'clangd', 'erlangls', 'metals' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  }
end

local sumneko_binary = "lua-language-server"
require'lspconfig'.lua_ls.setup {
    on_attach = on_attach,
    cmd = {sumneko_binary},
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            }
        }
    }
}

require'lspconfig'.cmake.setup {
    on_attach = on_attach,
    cmd = {"cmake-language-server"},
    filetypes = {"cmake"},
    init_options = {
        buildDirectory = "build/"
    }
}

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = { border = "single", scope = 'cursor' },
})

EOF

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
      find_files = {
          theme = "dropdown",
          }
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
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript", "cpp" },

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
noremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
"" Only set if you have telescope installed
nnoremap gr <cmd>lua require('goto-preview').goto_preview_references()<CR>

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
  focus_on_open = true; -- Focus the floating window when opening it.
  dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
  force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
  bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
}
EOF

lua << EOF
require('glow-hover').setup{
    border = 'rounded'
}
EOF

"---------- vim-easy-align -----------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"lua << EOF


"
"metals_config = require("metals").bare_config()
"-- Example of settings
"metals_config.settings = {
"  showImplicitArguments = true,
"  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
"--  serverVersion = "0.10.9+133-9aae968a-SNAPSHOT",
"}
"
"local capabilities = vim.lsp.protocol.make_client_capabilities()
"metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
"
"vim.cmd([[augroup lsp]])
"vim.cmd([[autocmd!]])
"-- cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
"-- NOTE: You may or may not want java included here. You will need it if you want basic Java support
"-- but it may also conflict if you are using something like nvim-jdtls which also works on a java filetype
"-- autocmd.
"vim.cmd([[autocmd FileType java,scala,sbt lua require("metals").initialize_or_attach(metals_config)]])
"vim.cmd([[augroup end]])
"EOF
