return {
  " neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require('lspconfig')
    local lua_config = require('elwapo.config.lsp.lua_ls')
    vim.notify("hello")
    vim.notify(type(lua_config))
    lspconfig.lua_ls.setup(lua_config)

  end
}
