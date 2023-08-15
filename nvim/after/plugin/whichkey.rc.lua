local status, wk = pcall(require, 'which-key')
if (not status) then return end

vim.api.nvim_set_hl(0, "WhichKeyFloat", { ctermfg=0,  ctermbg=0 })

wk.setup({
    window = {
        border = 'rounded'
    }
})

-- toggleterm:lazygit
local lazygit = require'toggleterm.terminal'.Terminal:new {
  cmd = 'lazygit',
  hidden = true,
  direction = 'float'
}

local mappings = {
    e = {':NvimTreeToggle<CR>', 'Toggle filetree'},
    o = {':Telescope find_files<CR>', 'Open Telescope'},
    f = {':Telescope live_grep<CR>', 'Find in files'},
    t = {
        name = 'Open Terminal',
        f = {':ToggleTerm<CR>', 'Open Terminal on Float'},
        t = {':ToggleTerm direction=tab<CR>', 'Open Terminal in Tab'},
        s = {':ToggleTerm size=40 direction=vertical<CR>', 'Open Terminal on Side'}
    },
    d = {':Dashboard<CR>', 'Open Dashboard'},
    l = {
        name = 'LSP Settings',
        i = {':LspInfo<CR>', 'List connected language servers'},
        k = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
        K = { "<cmd>Lspsaga hover_doc<cr>", "Hover Commands" },
        w = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', "Add Workspace Folder" },
        W = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', "Remove Workspace Folder" },
        l = {
          '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
          "List Workspace Folders"
        },
        t = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', "Type Definition" },
        d = { '<cmd>lua vim.lsp.buf.definition()<cr>', "Go To Definition" },
        D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', "Go To Declaration" },
        r = { '<cmd>lua vim.lsp.buf.references()<cr>', "References" },
        R = { '<cmd>Lspsaga rename<cr>', "Rename" },
        a = { '<cmd>Lspsaga code_action<cr>', "Code Action" },
        e = { '<cmd>Lspsaga show_line_diagnostics<cr>', "Show Line Diagnostics" },
        n = { '<cmd>Lspsaga diagnostic_jump_next<cr>', "Go To Next Diagnostic" },
        N = { '<cmd>Lspsaga diagnostic_jump_prev<cr>', "Go To Previous Diagnostic" }
    },
    g = {function() lazygit:toggle() end, 'Open lazygit'},
    u = {
        name = 'Utils',
        r = { '<Plug>RestNvim', 'Run HTTP REST Client' },
        t = { ':TOC<CR>', 'Create markdown table of content'}
    },
    p = { '<cmd>lua require("nabla").toggle_virt()<CR>', 'LaTeX Preview' }
}

local opts = {
    prefix = '<leader>'
}

wk.register(mappings, opts)
