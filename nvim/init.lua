local opt = vim.opt

opt.autoread=true
vim.api.nvim_command('autocmd BufEnter,FocusGained,VimResume * checktime')
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

vim.g.coc_global_extensions = {'coc-pairs', 'coc-pyright', 'coc-tsserver', 'coc-java', 'coc-go'}

-- plugins

local packer = require'packer'
packer.startup(function()
  local use = use
  use 'ianding1/leetcode.vim'
  use 'dag/vim-fish'
  use 'folke/tokyonight.nvim'
  use 'rebelot/kanagawa.nvim'
  use 'google/vim-jsonnet'
  use 'mhinz/vim-signify'
  use 'scrooloose/nerdcommenter'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'wbthomason/packer.nvim'
  use 'solarnz/thrift.vim'
  use 'michaeljsmith/vim-indent-object'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'jremmen/vim-ripgrep'
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

vim.cmd[[colorscheme kanagawa]]

require('lualine').setup {
  tabline = {
    lualine_a = {'buffers'},
  },
}

local noremap = function (modes, left, right)
  for mode in modes:gmatch"." do
    vim.api.nvim_set_keymap(mode,left,right,{noremap=true})
  end
end

noremap('nv',';',':')
noremap('nv','<leader>f',':FormatLines<CR>')
noremap('nv','qj',':cn<CR>')
noremap('nv','qk',':cp<CR>')


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
noremap('n','<C-o>',':Telescope find_files<CR>')
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

vim.g.leetcode_browser = 'chrome'
vim.g.leetcode_solution_filetype = 'python3'
vim.g.leetcode_hide_paid_only = 1
vim.g.leetcode_problemset = 'algorithms'

-- bits i was too lazy to port from .vimrc
vim.cmd('source ~/.config/nvim/config.vim')

