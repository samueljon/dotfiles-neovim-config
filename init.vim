"""""""""""""""""""""""""""""""""""""""""
"
" Author: Samúel Jón Gunnarsson
" Description: Neovim resource file aka init.vim
"
"""""""""""""""""""""""""""""""""""""""""

" Initialize packer.nvim for managing plugins
lua << EOF
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'lewis6991/gitsigns.nvim'
  use 'editorconfig/editorconfig-vim'
  use 'terryma/vim-multiple-cursors'
  use 'sheerun/vim-polyglot'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'nvim-lua/plenary.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use "lunarvim/synthwave84.nvim"
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
end)


EOF

"filetype plugin indent on    "Enable filetype detection and plugins"

"Check if environment is set to unicode and set file encodings accordingly"
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=ucs-bom,utf-8,latin1
endif


" Basic Settings"
set number              " Show line numbers"
set ruler               " Always show the cursor position in the status line"
set title               " Show the title of the current window"
set smarttab            " Enable intelligent tab handling; inserts correct number of spaces"
set incsearch           " Highlight matches as you type during search"
set wildmenu            " Enable enhanced command-line completion with visual suggestions"
set termguicolors       " Enable support for 24-bit RGB color in the terminal"
set hlsearch            " Highlight all matches of the last search"

" Display symbols for whitespace characters (Optional)"
set list                " Display whitespace characters, such as trailing spaces and tabs"
set listchars=trail:⋅,nbsp:⋅,tab:▷⋅ " Define symbols to represent different types of whitespace"
set background=dark     " Set background to dark for solarized theme compatibility"
let &guicursor = &guicursor . ",a:blinkon0" " Disable the blinking cursor"
set showcmd             " Show the current command being typed in the status line"
set showmode            " Display the current mode (e.g., INSERT, VISUAL)"


set tags=tags;/

"GUI-specific settings (Optional: Update for Neovim GUI)"
if has("gui_running")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set guioptions=T
    endif
endif

" Check if synthwave84 colorscheme is installed"
lua << EOF
local synthwave_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/synthwave84.nvim'
if vim.fn.empty(vim.fn.glob(synthwave_path)) == 0 then
  require('synthwave84').setup({
    glow = {
      error_msg = true,
      type2 = true,
      keyword = true,
      operator = false,
      _current_target = true,
      _visible_target = true,
      _inactive_target = true,
    }
  })
  vim.cmd('colorscheme synthwave84')
else
  vim.cmd('colorscheme default')
end
EOF

augroup indent_settings
    au!
    au BufEnter *.html setl autoindent smartindent
augroup END

" Folding settings"
set foldmethod=syntax
set nofoldenable

" Custom key mappings"
let mapleader = ","

" Nvim-Tree settings (replaces NERDTree)"
nnoremap <leader>t :NvimTreeToggle<cr>
lua << EOF
require'nvim-tree'.setup {}
EOF

set fillchars+=stl:\ ,stlnc:\
set laststatus=2

" GitSigns settings (replaces GitGutter)"
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = {text = '∙'},
    change       = {text = '∙'},
    delete       = {text = '∙'},
    changedelete = {text = '∙'},
  },
}

-- Define highlights for GitSigns
vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitGutterAdd' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitGutterChange' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitGutterDelete' })
vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'GitSignsAddNr' })
vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'GitSignsChangeNr' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'GitSignsDeleteNr' })
vim.api.nvim_set_hl(0, 'GitSignsAddLn', { link = 'GitSignsAddLn' })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { link = 'GitSignsChangeLn' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { link = 'GitSignsDeleteLn' })

EOF

" Lualine settings (replaces Lightline)"
lua << EOF
require('lualine').setup {
  options = {
    themes = 'powerline',
    icons_enabled = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
EOF

" Disable arrow keys to encourage hjkl traversal"
map <up> :echoerr "Stop being stupid"<CR>
map <down> :echoerr "Stop being stupid"<CR>
map <left> :echoerr "Stop being stupid"<CR>
map <right> :echoerr "Stop being stupid"<CR>

