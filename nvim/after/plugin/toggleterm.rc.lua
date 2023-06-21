local status, term = pcall(require, "toggleterm")
if (not status) then return end

term.setup{
    hide_numbers = true,
    shade_filetypes = {},
    autochdir = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'float',
    shell = vim.o.shell,
    auto_scroll = true,
    float_opts = {
      border = 'rounded'
    }
}