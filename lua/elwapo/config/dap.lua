local dap_ok, dap = pcall(require, "dap")
if dap_ok then
  vim.notify("unable to load dap")
end

local dap_ui_ok, dap_ui = pcall(require, "dapui")
if dap_ui_ok then
  vim.notify("unable to load dap ui")
end

--my own littel heaven 
local env_loader_ok, env_loader = pcall(require, "elwapo.env-loader")
if not env_loader_ok then
  vim.notify("unable to load env loader")
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



dap.configuration.c = require("elwapo.config.dap-settings.c").Setup(env_loader)
dap.configuration.cpp = require("elwapo.config.dap-settings.cpp").Setup(env_loader)
dap.configuration.rust =require("elwapo.config.dap-settings.rust").Setup(env_loader)
dap.configuration.python =require("elwapo.config.dap-settings.python").Setup(env_loader)
dap.configuration.go = require("elwapo.config.dap-settings.go").Setup(env_loader)
