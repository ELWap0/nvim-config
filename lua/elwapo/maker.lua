local function run_cmd(cmd)
  local args = type(cmd) == "string" and vim.split(cmd, "%s+") or cmd
  local proc = vim.system(args, { text = true })
  local result = proc:wait()
  if result.code ~= 0 then
    return false, result.stderr
  end
  return true, result.stdout
end


local function is_real_target(t)
  return t
     and t:match("^[%w_%.%-]+$")   -- only letters, digits, _, ., -
     and not t:match("^%.")        -- not starting with dot
     and not t:match("/")          -- not a path
end

local function get_targets(arg_lead,cmd_line, cursor_pos)
  local cmd = "make -qp"
  local ok, targets = run_cmd(cmd)
  if not ok then
    vim.notify("unable to get make targets -> " .. targets, vim.log.levels.WARN)
    return {}
  end
  local results = {}
  for _, line in ipairs(vim.split(targets, "\n")) do
    local target = line:match("^([%w_%.%-]+):")
    if is_real_target(target) and target:lower():match("^" .. arg_lead:lower()) then
      table.insert(results, target)
    end
  end
  return results
end

local function make(target)
  local cmd = "make "..target
  local ok, error_msg  = run_cmd(cmd)
  if not ok then
    vim.notify("error running make ->"..error_msg, vim.log.levels.ERROR)
    return
  end
end

vim.api.nvim_create_user_command("NMaker",
function(opts)
  local target = opts.args
  make(target)
end, {nargs = '?',
      complete = get_targets})

local M = {}
M.make = make
return M
