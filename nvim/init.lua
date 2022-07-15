local opt = vim.opt

opt.autoread=true
opt.backspace='indent,eol,start'
opt.cmdheight=2
opt.expandtab=true
opt.formatoptions='croql'
opt.hidden=true
opt.history=200
opt.incsearch=true
opt.mouse='a'
opt.shiftwidth=2
opt.shortmess='filnxtToOFI'
opt.number=true
opt.signcolumn='number'
opt.tabstop=2
opt.updatetime=300
opt.wildmode='longest:full,full'

for _,mode in pairs({'n','v'}) do
	vim.api.nvim_set_keymap(mode,';',':',{noremap=true})
	vim.api.nvim_set_keymap(mode,'<leader>f',':FormatLines<CR>',{noremap=true})
end

vim.api.nvim_set_keymap('n','<C-p>',':Telescope find_files<CR>',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>w',':bd<CR>',{noremap=true})

-- plugins

local packer = require'packer'
packer.startup(function()
  local use = use
  use 'folke/tokyonight.nvim'
  use 'google/vim-jsonnet'
  use 'mhinz/vim-signify'
  use 'scrooloose/nerdcommenter'
  use 'tpope/vim-surround'
  use 'wbthomason/packer.nvim'
  use {'neoclide/coc.nvim', branch = 'release'}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/plenary.nvim'}}
  }
  use {
    'google/vim-codefmt',
    requires = {{'google/vim-maktaba'}, {'google/vim-glaive'}}
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {
    'kdheepak/tabline.nvim',
    config = function() require'tabline'.setup {enable = false} end,
    requires = {'hoob3rt/lualine.nvim', 'kyazdani42/nvim-web-devicons'}
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

end)

local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-u>"] = false,
      },
    },
  }
}

vim.g.tokyonight_style = "night"
vim.cmd[[colorscheme tokyonight]]

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {require'tabline'.tabline_buffers},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {}
}
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"lua","java"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
