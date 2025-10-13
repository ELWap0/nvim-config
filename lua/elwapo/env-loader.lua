local M = {}
M.vars = {}
M.checked = false

local function trim(str)
  return str:gsub("^%s*(.-)%s*$", "%1")
end

local function load_env()
  local path = vim.fn.getcwd().."/project-vars.env"
  local fd = io.open(path,'r')
  M.checked = true
  if not fd then
    return false
  end
  for line in fd:lines() do
    line = line:match("^%s*(.-)%s*$")--trim
    if line ~= "" and not line:match("^#") then
      local values = vim.split(line, '=', {trimempty=true})
      local key , value = trim(values[1]), trim(values[2])
      if key ~= "" then
        M.vars[key] = value
      end
    end
  end
  return true
end

local function query_vars(var_name)
  if not M.checked then
    load_env()
  end
  local value =  M.vars[var_name]
  if value == nil then
   vim.notify(var_name.." does not exist", vim.log.levels.INFO)
  end
  return value
end

local function view_vars()
  if not M.checked then
    return {}
  end
  local keys = {}
  for key, _ in pairs(M.vars) do
    table.insert(keys,key)
  end
  return keys
end

vim.api.nvim_create_user_command("QueryLocalVars",
function(opts)
  local  target = opts.args
  query_vars(target)
end,
{
  nargs = '?',
  complete = view_vars
})

--debug
--vim.api.nvim_create_user_command("ViewVars",
--function()
--  vim.notify("vars are:\n")
--  if not load_env() then
--    vim.notify("missing project-vars.env")
--  end
--  for  key, values in pairs(M.vars) do
--    vim.notify(key.." = "..values)
--  end
--end,{})
--debug




M.load = load_env
return M
