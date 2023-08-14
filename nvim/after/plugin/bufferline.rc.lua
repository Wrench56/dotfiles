local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup({
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true
            }
        },
        separator_style = "slant"
    }
})


vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
