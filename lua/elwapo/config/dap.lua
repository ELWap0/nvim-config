local dap_ok, dap = pcall(require, "dap")
if dap_ok then
  vim.notify("unable to load dap")
end

local dap_ui_ok, dap_ui = pcall(require, "dapui")
if dap_ui_ok then
  vim.notify("unable to load dap ui")
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


local debug_config = require("lua.elwapo.launch").read(vim.fn.getcwd().."launch.json")

dap.configuration.c = require("elwapo.config.dap-settings.c").Setup(debug_config)
dap.configuration.cpp = require("elwapo.config.dap-settings.cpp").Setup(debug_config)
dap.configuration.rust =require("elwapo.config.dap-settings.rust").Setup(debug_config)
dap.configuration.python =require("elwapo.config.dap-settings.python").Setup(debug_config)
dap.configuration.go = require("elwapo.config.dap-settings.go").Setup(debug_config)
