local dap_ok, dap = pcall(require, "dap")
if dap_ok then
	vim.notify("unable to load dap")
end

dap.adapters.c = function(cb, config)
	if config.type == "openocd" then
		cb({
			type = "executable",
			command = "arm-none-eabi-gdb",
			args = {
				"--interpreter=m12",
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
	elseif config.type == "gdb" then
		if config.request == "launch" then
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
end
