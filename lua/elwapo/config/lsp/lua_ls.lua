local blink_ok, blink = pcall(require,"blink.cmp")
if not blink_ok then
  vim.notify("unable to load blink.cmp")
  return {}
end

local M = {
  capabilities = blink.get_lsp_capabilities(),
  settings = {
    Lua = {},
  },
}
M.on_init = function(client)
  if client.workspace_folders then
    local path = client.workspace_folders[1].name
    if path ~= vim.fn.stdpath('config') and vim.uv.fs_stat(path..'/.luarc.jsonc') then
      return
    end
  end
  client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
    runtime = {
      version = 'LuaJIT',
      path = {
        'lua/?.lua',
        'lua/?/init.lua',
      },
    },
    workspace = {
      checkThirdParty = false,
      library = {
        vim.env.VIMRUNTIME
      },
    },
    diagnostics = {
      globals = { "vim" },
    },
  })
end

return M
