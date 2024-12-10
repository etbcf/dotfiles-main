return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.icons").setup()

      require("lualine").setup({
        sections = {
          lualine_c = {
            'filename',
            { 'diagnostics', sources = {'nvim_lsp'}, symbols = {error = '✘', warn = '⚠', info = 'ℹ'} }
          },
        }
      })
    end,
  },
}
