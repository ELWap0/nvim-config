local ok,_ = pcall(require, "lspconfig")
if not ok then 
  vim.notify("unable to laod lspconfig")
	return
end

require("elwapo.lsp.mason")
require("elwapo.lsp.none-ls")
require("elwapo.lsp.handler")
