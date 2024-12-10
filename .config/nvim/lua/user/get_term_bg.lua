local M = {}

local modified = false

-- Autocommand to set the background color when UI enters or color scheme changes
vim.api.nvim_create_autocmd({'UIEnter', 'ColorScheme'}, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if normal.bg then
      io.write(string.format('\027]11;#%06x\027\\', normal.bg))
      modified = true
    end
  end,
})

-- Autocommand to reset the background color when UI leaves
vim.api.nvim_create_autocmd('UILeave', {
  callback = function()
    if modified then
      io.write('\027]111\027\\')
    end
  end,
})

return M

