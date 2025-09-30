return {
  "neovim/nvim-lspconfig",
  priority = 1000,
  opts = function(_,opts)
      opts.setup = opts.setup or {}
      opts.setup.clnagd = function(_,_)
        return true
      end
  end,
  config = function()
    require('elwapo.config.lsp-config')
    local lua_config = require('elwapo.config.lsp.lua_ls')
    local clangd_config = require('elwapo.config.lsp.clangd')
    vim.lsp.config("lua_ls", lua_config)
    vim.lsp.config("clangd", clangd_config)
  end,
}
