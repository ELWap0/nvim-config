local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  vim.notify("error loading dap")
end

dap.adapters.c = function(cb, config)
  if config.request == "openocd" then
    cb({
      type = "executable",
      command = "arm-none-eabi-gdb",
      args = {
        "--interpreter=mi2",
        "-ex",
        "target extended-remote localhost:3333",
        "-ex",
        "monitor reset halt",
        "-ex",
        "load",
        "-ex",
        "continue",
      },
    })
  elseif config.request == "launch" then
    cb({
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    })
  elseif config.request == "remote" then
    cb({
      type = "server",
      host = config.host or "127.0.0.1",
      port = config.port,
    })
  end
end

local M = {}
M.Setup = function(config)
  local c = { config }
  return c
end
return M
