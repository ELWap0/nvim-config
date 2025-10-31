local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
	vim.notify("unable to load dap")
end

dap.adapters.python = function(cb, config)
	if config.request == "launch" then
		vim.defer_fn(function()
			cb({
				type = "executable",
				command = "python",
				args = { "-Xfrozen_modules=off", "-m", "debugpy.adapter" },
			})
		end, 300) -- 100ms delay
	elseif config.request == "attach" then
		vim.defer_fn(function()
			cb({
				type = "server",
				host = config.host,
				port = config.port,
				options = { source_filetype = "python" },
			})
		end, 300)
	end
end

local M = {}
M.Setup = function(config)
	vim.notify("in setup")
	if config.request == "launch" then
		config.host = nil
		config.port = nil
	elseif config.request == "attach" then
		if not config.host or config.host == "" then
			vim.notify("missing host", vim.log.levels.ERROR)
			return {}
		end
		if not config.port or config.port == "" then
			vim.notify("missing port", vim.log.levels.ERROR)
			return {}
		end
	else
		vim.notify("request is not valid", vim.log.levels.ERROR)
		return {}
	end
	return { config }
end
return M
