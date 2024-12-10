-- Restore last cursor position
---------------------------------------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line = mark[1]
    local col = mark[2]

    -- If the cursor position is valid (i.e., not outside the file)
    if line > 0 and line <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, {line, col})
    end
  end,
})

-- Function to run the file based on its type
---------------------------------------------------------------------------------------------------------------------
function run_file()
    local file_ext = vim.fn.expand('%:e')  -- Get file extension

    -- Conditionally save the file if it's a Python file
    if file_ext == 'py' then
        vim.cmd('w')  -- Save the file
    end

    -- Save the current file before running
    vim.cmd('w')

    -- Determine the command to run based on file extension
    local command = ""
    if file_ext == 'sh' then
        command = 'bash ' .. vim.fn.expand('%:p') .. ' && read -n 1 -s -r -p "Press any key to continue..."'
    elseif file_ext == 'py' then
        command = 'python3 ' .. vim.fn.expand('%:p') .. ' && read -n 1 -s -r -p "Press any key to continue..."'
    else
        print('Unsupported file type: ' .. file_ext)
        return
    end

    -- Open ToggleTerm and run the command
    local Terminal = require('toggleterm.terminal').Terminal
    local term = Terminal:new({ cmd = command, hidden = true, close_on_exit = true })  -- Create a new terminal instance
    term:toggle()  -- Toggle the terminal to open it and run the command
end
-- Map F5 to the run_file function
vim.api.nvim_set_keymap('n', '<F5>', ':lua run_file()<CR>', { noremap = true, silent = true })

-- Maximize the current split
vim.api.nvim_set_keymap('n', '<leader>m', ':wincmd _<CR>:wincmd \\|<CR>', { noremap = true, silent = true })

-- Rebalance all splits
vim.api.nvim_set_keymap('n', '<leader>r', ':wincmd =<CR>', { noremap = true, silent = true })
