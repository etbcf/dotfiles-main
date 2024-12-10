local M = {}

function M.setup()
  -- Check if running inside TMUX
  if vim.fn.exists('$TMUX') ~= 0 then
    -- Automatically rebalance splits on VimResized or FocusGained
    vim.api.nvim_create_autocmd({ "VimResized", "FocusGained" }, {
      callback = function()
        -- Adjust all windows equally
        vim.cmd("wincmd =")
        -- Enable text wrapping
        vim.o.wrap = true
        -- Adjust the text width according to window size
        vim.o.textwidth = vim.api.nvim_win_get_width(0) - 2  -- 2 for padding/scrollbar
      end,
    })

    -- Periodically check and rebalance windows (helpful for focusing between tmux panes)
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.cmd("wincmd =")
        -- Ensure text wrapping is always enabled when resizing
        vim.o.wrap = true
        vim.o.textwidth = vim.api.nvim_win_get_width(0) - 2
      end,
    })
  end
end

return M

