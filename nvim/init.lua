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
