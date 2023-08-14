vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap

function smap(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    map(mode, lhs, rhs, options)
end

-- Insert mode text selection with arrows
-- similar to: set keymodel=startsel,stopsel

smap('i', '<S-Left>', '<Left><C-o>v<Esc>')
smap('i', '<S-Right>', '<C-o>v')
smap('i', '<S-Up>', '<Left><C-o>v<Up><Right>')
smap('i', '<S-Down>', '<C-o>v<Down><Left>')
smap('i', '<C-S-Left>', '<S-Left><C-Left>')
smap('i', '<C-S-Right>', '<S-Right><C-Right>')

smap('v', '<S-Left>', '<Left>')
smap('v', '<S-Right>', '<Right>')
smap('v', '<S-Up>', '<Up>')
smap('v', '<S-Down>', '<Down>')

-- Unselect when not using shift

smap('v', '<Left>', '<Esc>i<Left>')
smap('v', '<Right>', '<Esc>i<Right>')
smap('v', '<Up>', '<Esc>i<Up>')
smap('v', '<Down>', '<Esc>i<Down>')

-- Usual CTRL stuff
-- Use "* or "+ to use system clipboard

smap('v', '<C-c>', '"*yy<Esc>i')
smap('v', '<C-x>', '"*dd<Esc>i')
smap('i', '<C-v>', '<Esc>"*pi')


-- Will I regret this? Maybe...

smap('v', 'h', '<Delete><Esc>ih') -- TODO: Do this to all the different keys


-- ========================================

-- Terminal

smap('t', '<C-t>', '<Cmd>ToggleTermToggleAll<CR>')
smap('n', '<C-t>', '<Cmd>ToggleTermToggleAll<CR>')

-- Trouble

smap('n', '<C-p>', '<Cmd>TroubleToggle<CR>')
smap('i', '<C-p>', '<Cmd>TroubleToggle<CR>')

