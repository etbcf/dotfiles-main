return {
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/vimwiki",   -- Directory for your notes
          syntax = "markdown",  -- Use Markdown syntax
          ext = ".md",          -- File extension
        },
      }
    end,
  },
}


