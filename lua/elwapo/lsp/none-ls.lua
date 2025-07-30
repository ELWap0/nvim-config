local null_ok, null = pcall(require, "null-ls")
if not null_ok then
  return 
end

local formatting = null.builtins.formatting
local diagnostics = null.builtins.diagnostics


null.setup({
  debug = false,
  sources = {

  }
})
