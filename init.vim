"""""""""""""""""""""""""""""""""""""""""
" Neovim Initialization File            "
" Author: Samúel Jón Gunnarsson         "
"""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""
" Plugin Management and Other Settings  "
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
  use 'lunarvim/synthwave84.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
end)
EOF

""""""""""""""""""""""""""""""""""""""""""""""""
"Check if synthwave84 colorscheme is installed "
""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""
" GitSigns settings                     "
"""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""
" Lualine settings (replaces Lightline)"
"""""""""""""""""""""""""""""""""""""""""
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

"#############################################################################################"
" Set / Let options and keymappings                                                           "
"#############################################################################################"
set number              " Show line numbers" " Show line numbers in the editor. "
set ruler               " Always show the cursor position in the status line" " No detailed explanation provided. "
set title               " Show the title of the current window" " No detailed explanation provided. "
set smarttab            " Enable intelligent tab handling; inserts correct number of spaces" " No detailed explanation provided. "
set incsearch           " Highlight matches as you type during search" " No detailed explanation provided. "
set wildmenu            " Enable enhanced command-line completion with visual suggestions" " No detailed explanation provided. "
set termguicolors       " Enable support for 24-bit RGB color in the terminal" " No detailed explanation provided. "
set hlsearch            " Highlight all matches of the last search" " No detailed explanation provided. "
set list                " Display whitespace characters, such as trailing spaces and tabs" " No detailed explanation provided. "
set listchars=trail:⋅,nbsp:⋅,tab:▷⋅ " Define symbols to represent different types of whitespace" " No detailed explanation provided. "
set background=dark     " Set background to dark for solarized theme compatibility" " No detailed explanation provided. "
set showcmd             " Show the current command being typed in the status line" " No detailed explanation provided. "
set showmode            " Display the current mode (e.g., INSERT, VISUAL)" " No detailed explanation provided. "

set tags=tags;/         " No detailed explanation provided. "
set guioptions=T        " No detailed explanation provided. "
set foldmethod=syntax   " No detailed explanation provided. "
set nofoldenable        " No detailed explanation provided. "
set fillchars+=stl:\ ,stlnc:\ " No detailed explanation provided. "
set laststatus=2        " No detailed explanation provided. "

let &guicursor = &guicursor . ",a:blinkon0" " Disable the blinking cursor" " Set the &guicursor variable to customize behavior. "

"""""""""""""""""""""""""""""""""""""""""
" Disable arrow keys to encourage hjkl traversal"
"""""""""""""""""""""""""""""""""""""""""
map <up> :echoerr "Stop being stupid"<CR> " Map <up> to perform :echoerr for better usability. "
map <down> :echoerr "Stop being stupid"<CR> " Map <down> to perform :echoerr for better usability. "
map <left> :echoerr "Stop being stupid"<CR> " Map <left> to perform :echoerr for better usability. "
map <right> :echoerr "Stop being stupid"<CR> " Map <right> to perform :echoerr for better usability. "

" Custom key mappings"
let mapleader = "," " Set the mapleader variable to customize behavior. "

" Nvim-Tree settings"
nnoremap <leader>t :NvimTreeToggle<cr> " Map <leader>t to perform :NvimTreeToggle<cr> for better usability. "
lua << EOF
require'nvim-tree'.setup {}
EOF

