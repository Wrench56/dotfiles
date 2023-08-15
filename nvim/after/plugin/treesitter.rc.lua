local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

-- Already save to use treesitter plugins --
autotag = {
    enable = true
}


ts.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "rust", "python",
     "cpp", "html", "http", "javascript", "json", "latex",
     "java", "make", "markdown", "pascal", "perl", "php",
     "regex", "ruby", "scss", "css", "sql", "solidity",
     "vim"},
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      disable = {},
      additional_vim_regex_highlighting = false,
    },
    -- Rainbow plugin --
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
    }
  }
