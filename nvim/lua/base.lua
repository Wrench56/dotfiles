vim. scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.hlsearch = true

vim.opt.showcmd = true
vim.opt.cmdheight = 1

vim.opt.splitbelow = false
vim.opt.splitright = false

vim.opt.termguicolors = true

-- Indentation

vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Line numbers

vim.wo.number = true

-- Fold

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.statuscolumn = '%=%l%s%#FoldColumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? " " : " ") : "  " }%*'

-- Autocommands

vim.api.nvim_create_autocmd('BufRead', {command = 'setlocal signcolumn=yes'})
vim.api.nvim_create_autocmd('BufNewFile', {command = 'setlocal signcolumn=yes'})

-- Turn off indentation for special buffers (like dashboard)

vim.g.indent_blankline_filetype_exclude = {'dashboard'}
