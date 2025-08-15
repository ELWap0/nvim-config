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

--- adapter
dap.adapters.gcc = {
  type = 'executable',
  command = "gcc",
  args = {"--interpreter=dap", "--eval-command", "set print pretty on"},
}

dap.adapters.python_virt = {
  type = 'executable',
  command = '',
  args = {'-m', 'debugpy.adapter'},
  options = { source_filetype = 'python' }
}
--- config
local c_config = {
  local_conf = {
  },
  remote_conf = {
  },
}
local rust_config = {
  local_conf = {
  },
  remote_conf = {
  },
}
local c_opt = env_loader.C_OPT or "local_conf"
local rust_opt = env_loader.RUST_OPT or "local_conf"

dap.configuration.c = c_config[c_opt]
dap.configuration.cpp = dap.configuration.c
dap.configuration.rust = rust_config[rust_opt]
---
