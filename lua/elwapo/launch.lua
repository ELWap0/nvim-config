local M = {}
M.base = {
	request = "launch",
	name = "Launch",
	program = "${fileDirname}",
	args = {},
	env = {},
	envFile = "",
	cwd = "${workspaceFolder}",
	port = "",
	stopOnEntry = false,
}

local function ext(data)
	local extension
	vim.fn.fnamemodify(vim.fn.expand("%"), ":e")
	if extension == "c" then
		data.type = "gdb"
	elseif extension == "cpp" then
		data.type = "gdb"
	elseif extension == "go" then
		data.type = "delve"
	elseif extension == "py" then
		data.type = "python"
		data.program = "${fileBasename}"
	else
		M.base.type = ""
	end
end

M.read = function()
	local path = vim.fn.getcwd() .. "launch.json"
	local file = io.open(path, "r")
	local jsonData
	if file then
		local data = file:read("*a")
		file:close()
		jsonData = vim.json.decode(data)
	else
		jsonData = M.base
		ext(jsonData)
	end
	return jsonData
end

M.generate = function()
	local json = require("dkjson")
	local path = vim.fs.joinpath(vim.fn.getcwd(), "launch.json")
	if vim.loop.fs_stat(path) then
		vim.notify(path .. " already exits", vim.log.levels.ERROR)
		return
	end
	local jsonData = json.encode(M.base, {
		indent = true,
		keyorder = {
			"type",
			"request",
			"name",
			"program",
			"args",
			"env",
			"envFile",
			"cwd",
			"port",
			"stopOnEntry",
			"console",
		},
	})
	ext(jsonData)
	local file = io.open(path, "w")
	if not file then
		vim.notify("Failed to create: " .. path, vim.log.levels.ERROR)
		return
	end
	vim.notify("Created: " .. path, vim.log.levels.INFO)
	file:write(jsonData)
	file:close()
end

vim.api.nvim_create_user_command("GenLaunch", function()
	M.generate()
end, {})

return M
