local M = {
    "vimwiki/vimwiki",
    lazy = false, -- Carrega automaticamente no início
}

M.config = function()
    -- Configuração básica do Vimwiki
    vim.g.vimwiki_list = {
        {
            path = "~/vimwiki",    -- Diretório para suas notas
            syntax = "markdown",  -- Usar Markdown
            ext = ".md",          -- Extensão para os arquivos
        },
    }

    vim.g.vimwiki_global_ext = 0 -- Impedir que outros arquivos .md sejam tratados como Vimwiki
    vim.g.vimwiki_hl_headers = 1 -- Destacar cabeçalhos
    vim.g.vimwiki_auto_chdir = 1 -- Alterar para o diretório do wiki automaticamente
end

return M

