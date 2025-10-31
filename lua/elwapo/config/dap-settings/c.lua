local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
	vim.notify("error loading dap")
end
local default_port = 5678

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
			host = config.host,
			port = config.port,
		})
	end
end

local M = {}
M.Setup = function(config)
	if config.build ~= "" then
		local result = vim.cmd(config.build)
	end

	if config.port == "" then
		config.port = default_port
	end
	return { config }
end
return M
