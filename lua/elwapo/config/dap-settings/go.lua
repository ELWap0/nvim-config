local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  vim.notify("unable to load dap")
end


dap.adapters.go = function(cb, config)
  if config.request == 'local' then
    cb({
      type = 'server',
      port = config.port,
      host = "127.0.0.1",
      executable = {
        command = 'dlv',
        args = { 'dap', '-l', "127.0.0.1:" .. config.port, '--log', '--log-output=dap' },
        detached = vim.fn.has("") == 0,
      }
    })
  elseif config.request == 'remote' then
    cb({
      type = 'server',
      port = config.port,
      host = config.host,
      executable = {
        command = 'dlv',
        args = { 'dap', '-l', config.address .. ":" .. config.port, '--log', '--log-output=dap' },
        detached = vim.fn.has("") == 0,
      }
    })
  end
end

local M = {}
M.Setup = function(config)
  local c = { config }
  return c
end

return M
