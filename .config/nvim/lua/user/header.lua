local M = {
  'alpertuna/vim-header',
  config = function()
    -- Automatically use the system username as the author
    vim.g.header_field_author = vim.env.USER  -- Get the system username
    vim.g.header_field_email = 'your.email@example.com'  -- You can also make this dynamic if needed
    vim.g.header_field_timestamp_format = '%Y-%m-%d %H:%M:%S'
    vim.g.header_auto_update_on_save = 1
  end,
}

return M

