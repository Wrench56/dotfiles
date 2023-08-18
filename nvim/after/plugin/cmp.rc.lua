vim.g.completeopt="menu,menuone,noselect,noinsert"
vim.g.vsnip_snippet_dir = '~/.config/vsnip'

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local status, cmp = pcall(require, 'cmp')
if (not status) then return end

local status, lspkind = pcall(require, 'lspkind')
if (not status) then return end

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {

        -- ... Your other mappings ...
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<S-Down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
          end
        end, { "i", "s" }),
    
        ["<S-Up>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          end
        end, { "i", "s" }),
    },
    formatting = {
        format = lspkind.cmp_format(),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'crates' }
    },
    {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})


local signs = {Error = " ", Warn = " ", Hint = " ", Info = " "}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
end


-- Language servers (with mason.nvim)

require('mason').setup()
local status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if (not status) then return end
mason_lspconfig.setup_handlers {
    function (server_name)
        require('lspconfig')[server_name].setup {}
    end,
}

