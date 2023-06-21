require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

vim.api.nvim_set_hl(0, "LazyButton", { ctermbg=0 })
vim.api.nvim_set_hl(0, "LazyButtonActibe", { ctermfg=1, ctermbg=0 })
vim.api.nvim_set_hl(0, "Normal", { ctermbg=0 })
vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg=0 })
vim.api.nvim_set_hl(0, "EndOfBuffer", { ctermbg=0 })
vim.api.nvim_set_hl(0, "SignColumn", { ctermbg=0 })

vim.api.nvim_set_hl(0, "MsgSeparator", { ctermbg=0 })
vim.api.nvim_set_hl(0, "Conceal", { ctermbg=0 })
vim.api.nvim_set_hl(0, "Operator", { ctermbg=0 })
vim.api.nvim_set_hl(0, "Constant", { ctermbg=0 })
vim.api.nvim_set_hl(0, "Character", { ctermbg=0 })
vim.api.nvim_set_hl(0, "BufferLineInfoSelected", { ctermbg=0 })
vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg=0 })
vim.api.nvim_set_hl(0, "FoldColumn", { ctermbg=0 })

vim.api.nvim_set_hl(0, "LineNr", { ctermfg='White' })
vim.api.nvim_set_hl(0, "Folded", { ctermbg=0 })
vim.api.nvim_set_hl(0, "UfoCursorFoldedLine", { ctermbg=0 })

