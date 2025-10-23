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
  local path = vim.fn.getcwd().."launch.json"
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
    console = ""
  }
  local jsonData = vim.json.encode(data)
  local file = io.open(path, "w")
  if file then
    file:write(jsonData)
  end
end

return M
