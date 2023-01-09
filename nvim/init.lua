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
opt.ignorecase=true
opt.smartcase=true
vim.o.termguicolors = true

vim.g.coc_global_extensions = {'coc-pairs', 'coc-jedi', 'coc-tsserver', 'coc-java', 'coc-go'}

-- plugins

local packer = require'packer'
packer.startup(function()
  local use = use
  use 'folke/tokyonight.nvim'
  use 'google/vim-jsonnet'
  use 'mhinz/vim-signify'
  use 'scrooloose/nerdcommenter'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'wbthomason/packer.nvim'
  use 'michaeljsmith/vim-indent-object'
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
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use({
    'python-rope/ropevim',
    ft = "python"
  })
  use 'nvim-treesitter/nvim-treesitter-textobjects'

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

vim.cmd[[colorscheme tokyonight-night]]

require('lualine').setup {
  options = {
    icons_enabled = false,
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
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {}
}

local noremap = function (modes, left, right)
  for mode in modes:gmatch"." do
    vim.api.nvim_set_keymap(mode,left,right,{noremap=true})
  end
end

noremap('nv',';',':')
noremap('nv','<leader>f',':FormatLines<CR>')


_G.project_files = function()
  local utils = require('telescope.utils')
  local builtin = require('telescope.builtin')
  local _, ret, _ = utils.get_os_command_output({'git', 'rev-parse', '--is-inside-work-tree'})
  if ret == 0 then
      builtin.git_files()
  else
      builtin.find_files()
  end
end

noremap('n','<C-p>','<cmd>lua project_files()<CR>')
noremap('n','<leader>w',':bd<CR>')

noremap('nv','<TAB>',':bn<CR>')

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"lua","java","scala","go","python"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["a,"] = "@parameter.outer",
        ["i,"] = "@parameter.inner",
      },
    },
  },
}


-- bits i was too lazy to port from .vimrc
vim.cmd('source ~/.config/nvim/config.vim')

