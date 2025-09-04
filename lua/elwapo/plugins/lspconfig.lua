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
    local lspconfig = require('lspconfig')
    require('elwapo.config.lsp-config')
    local lua_config = require('elwapo.config.lsp.lua_ls')
    local clangd_config = require('elwapo.config.lsp.clangd')
    lspconfig.lua_ls.setup(lua_config)
    lspconfig.clangd.setup(clangd_config)
  end,
}
