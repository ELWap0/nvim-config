local M  = {}
M.vars = {}


local function split(line)
  local key, value = "", ""
  local start_i, end_i = string.find(line, '=', 1, true)
  if start_i then
    key = string.sub(line, 1, start_i-1)
    value = string.sub(line, end_i+1)
  end
  return key, value
end

function M.load_env()
  local path = vim.fn.getcwd() .. "/project-vars.env"
  local var_set = false
  local fd = io.open(path,'r')
  if not fd then
    return false
  end
  for line in fd:lines() do
    line = line:match("^%s*(.-)%s*$")--trim
    if line ~= "" and not line:match("^#") then
    local key , value = split(line)
      if key ~= "" then
        M.vars[key] = value
      end
    end
  end
  if M.var == nil then
    return false
  else
    return true
  end
end

return M
