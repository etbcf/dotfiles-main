-- File: ~/.config/nvim/lua/plugins/toggleterm.lua

local M = {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",  -- Load the plugin on very lazy event
}

function M.config()
  require("toggleterm").setup {
    size = 10,                          -- Set the terminal height (horizontal split)
    open_mapping = [[<C-\>]],           -- Mapping to toggle terminal (Ctrl+\ by default)
    hide_numbers = true,                -- Hide line numbers in terminal buffer
    shade_filetypes = {},
    shade_terminals = true,             -- Shade terminal background
    shading_factor = 2,                 -- Degree of background shading
    start_in_insert = true,             -- Start terminal in insert mode
    insert_mappings = true,             -- Apply open mapping in insert mode
    terminal_mappings = true,           -- Apply open mapping in terminal mode
    persist_size = true,                -- Preserve terminal size when toggling
    direction = 'horizontal',           -- Can be 'horizontal', 'vertical', 'float'
    close_on_exit = true,               -- Close terminal when the process exits
    shell = vim.o.shell,                -- Shell to execute inside terminal (uses system default)
    float_opts = {                      -- Options for floating terminal
      border = 'curved',
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    }
  }
end

return M

