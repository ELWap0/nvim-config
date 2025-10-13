local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  vim.notify("unable to load dap")
end


dap.adapters.delve = function(cb, config)
  if config.request == 'local' then
    cb({
      type = 'executable',
      command = ''
    })
  elseif config.request == 'remote' then
    cb({
      type = 'server',
      port = config.port,
      executable = {
        command = 'dlv',
        args = { 'dap', '-l', config.address..":"..config.port, '--log', '--log-output=dap'},
        detached = vim.fn.has("") == 0,
      }
    })
  end
end
