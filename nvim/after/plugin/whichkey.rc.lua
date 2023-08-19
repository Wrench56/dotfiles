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

local function toggle_spell_check()
    vim.opt.spell = not(vim.opt.spell:get())
end

local crates = require('crates')

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
    g = {
        name = 'Git tools',
        l = { function() lazygit:toggle() end, 'Open lazygit' },
        i = { '<cmd>Octo issue list<CR>', 'List GitHub issues' },
        p = { '<cmd>Octo pr list<CR>', 'List Pull Requests' },
        a = { '<cmd>GhActions<CR>', 'Open GitHub Actions tab' }
    },
    u = {
        name = 'Utils',
        r = { '<Plug>RestNvim', 'Run HTTP REST Client' },
        t = { ':TOC<CR>', 'Create markdown table of content' },
        v = { ':lua Toggle_venn()<CR>', 'Enable venn (diagram drawing)' },
        s = { toggle_spell_check, 'Toggle spell check' }
    },
    p = { '<cmd>lua require("nabla").toggle_virt()<CR>', 'LaTeX Preview' },
    c = {
        name = 'Cargo',
        r = { crates.reload, 'Reload' },
        u = { crates.update_crate, 'Update crate (v1.*.*)' },
        a = { crates.update_all_crates, 'Update all crates (v1.*.*)' },
        U = { crates.upgrade_crate, 'Upgrade crate (v*.*.*)' },
        A = { crates.upgrade_all_crates, 'Upgrade all crates (v*.*.*)' },
        d = { crates.show_dependencies_popup, 'Show dependencies' },
        f = { crates.show_features_popup, 'Show features' },
        i = { crates.show_crate_popup, 'Show info about crate' },
        v = { crates.show_versions_popup, 'Show versions' }
    }
}

vim.keymap.set('v', '<leader>cu', crates.update_crates, { silent = true })
vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { silent = true })

local opts = {
    prefix = '<leader>'
}

wk.register(mappings, opts)
