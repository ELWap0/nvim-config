local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  vim.notify("failed to load dap")
end

local dap_ui_ok, dap_ui = pcall(require, "dapui")
if not dap_ui_ok then
  vim.notify("failed to load dap ui")
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
dap.listeners.after.event_initialized["dapui_config"] = function()
  -- wait a tiny bit to ensure controls are registered
  vim.defer_fn(function()
    dap_ui.open({ reset = true })
  end, 100)
end

dap.listeners.after.terminate.dap_ui = function()
  dap_ui.close()
  pcall(function()
    require("dap.repl").close()
  end)
end

local debug_config = require("elwapo.launch").read()

if debug_config.type == "c" then
  dap.configurations.c = require("elwapo.config.dap-settings.c").Setup(debug_config)
elseif debug_config.type == "cpp" then
  dap.configurations.cpp = require("elwapo.config.dap-settings.cpp").Setup(debug_config)
elseif debug_config.type == "rust" then
  dap.configurations.rust = require("elwapo.config.dap-settings.rust").Setup(debug_config)
elseif debug_config.type == "python" then
  dap.configurations.python = require("elwapo.config.dap-settings.python").Setup(debug_config)
elseif debug_config.type == "go" then
  dap.configurations.go = require("elwapo.config.dap-settings.go").Setup(debug_config)
end

local M = {}
return M
