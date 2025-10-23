local M = {}
M.read = function()
  local path = vim.fn.getcwd().."launch.json"
  local file = io.open(path,"r")
  local jsonData
  if file then
    local data = file:read("*a")
    file:close()
    jsonData = vim.json.decode(data)
  else
    jsonData = vim.json.decode("{}")
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
	local data = {
		type = "",
		request = "",
		name = "",

		program = "",
		args = "",
		env = "",
		envFile = "",
		cwd = "",
		port = "",
		stopOnEntry = false,
		console = "",
	}
	local jsonData = json.encode(data, { indent = true })
	local file = io.open(path, "w")
	if not file then
		vim.notify("Failed to create: " .. path, vim.log.levels.ERROR)
		return
	end
	vim.notify("Created: " .. path, vim.log.levels.INFO)
	file:write(jsonData)
	file:close()
end

return M
