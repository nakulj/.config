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
opt.signcolumn='number'
opt.tabstop=2
opt.updatetime=300
opt.wildmode='longest:full,full'

for _,mode in pairs({'n','v'}) do
	vim.api.nvim_set_keymap(mode,';',':',{noremap=true})
end

-- plugins

local packer = require'packer'
packer.startup(function()
  local use = use
  use 'wbthomason/packer.nvim'
  use 'scrooloose/nerdcommenter'
  use 'tpope/vim-surround'
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
  end
)
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

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
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
