-- user/fzf.lua
local M = {
  "junegunn/fzf",
  run = './install --all', -- Isso instala o fzf no sistema
}

M.config = function()
  -- Configuração do fzf.vim para integrar com o Neovim
  -- O plugin fzf.vim oferece integração com o fzf para navegação de arquivos
  vim.g.fzf_command_prefix = 'Fzf' -- Prefixo para comandos Fzf

  -- Mapeamento de atalhos para o fzf no Neovim
  vim.api.nvim_set_keymap('n', '<leader>z', ':FZF<CR>', { noremap = true, silent = true })

  -- Outras opções para personalizar a experiência do fzf
  vim.g.fzf_layout = { down = '~40%' }
  vim.g.fzf_preview_window = 'right:50%:hidden'
end

return M

