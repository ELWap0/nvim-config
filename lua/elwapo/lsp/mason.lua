local servers = {
  "lua_ls",
  "gopls",
  "clangd",
  "pyright"
}


local settings = {
  ui = {
    border = "none",
    icons = {
			package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_isntallers = 4
}

local mason_ok, mason = pcall(require, "mason")
local config_ok, config = pcall(require, "mason-lspconfig")

if not mason_ok then
  nvim.notify("unable to laod mason")
end
if not config_ok then
  nvim.notify("unable to laod mason-lspconfig")
end


mason.setup(settings)
config.setup({
  ensure_installed = servers,
  automatic_installation = true,
})


local lsp_conf_ok, lsp_conf = pcall(require, "lspconfig")
if not lsp_conf_ok then
  return
end

local opts = {}
for _, server in pairs(servers) do 
  opt = {
    on_attach = require("elwapo.lsp.handler").on_attach,
    capabilities = require("elwapo.lsp.handler").capabilities,
  }
  server = vim.split(server, "@")[1]
  local require_ok, conf_opts = pcall(require, "elwapo.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end
  lsp_conf[server].setup(opts)
end
