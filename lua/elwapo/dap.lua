local dap_ok, dap = pcall(require, "dap")
if dap_ok then
  vim.notify("unable to load dap")
end

local dap_ui_ok, dap_ui = pcall(require, "dapui")
if dap_ui_ok then
  vim.notify("unable to load dap up")
end
dap.listeners.before.attach.dapui_config = function()
  dap_ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dap_ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dap_ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dap_ui.close()
end

--- adapter
dap.adapters.gcc = {
  type = 'executable',
  command = "gcc",
  args = {"--interpreter=dap", "--eval-command", "set print pretty on"},
}
--- config




dap.configuration.c = 
dap.configuration.cpp = 
---
