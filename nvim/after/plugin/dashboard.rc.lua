local status, dashboard = pcall(require, 'dashboard')
if (not status) then return end

local version_table = vim.version()
local version = tostring(version_table['major']) .. '.' .. tostring(version_table['minor']) .. '.' .. tostring(version_table['patch'])

dashboard.setup({
   config = {
      week_header = {
         enable = true,
         concat = '- Neovim v' .. version
      },
      disable_move = true,
      shortcut = {
         {
            desc = ' Update',
            group = '@property',
            action = 'Lazy update',
            key = 'u'
         },
         {
            desc = '󰚰 Mason',
            group = 'Directory',
            action = 'Mason',
            key = 'm'
         },
         {
            desc = ' Files',
            group = 'LineNr',
            action = 'Telescope find_files',
            key = 'f',
         },
         {
            desc = ' Health',
            group = 'DiagnosticHint',
            action = 'checkhealth',
            key = 'h',
         }
      },
      footer = {
         '',
         'Welcome aboard, Captain!'
      }
   },
})
