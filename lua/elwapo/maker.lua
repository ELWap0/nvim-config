local function run_cmd(cmd)
  local args = type(cmd) == "string" and vim.split(cmd, "%s+") or cmd
  local proc = vim.system(args, { text = true })
  local result = proc:wait()
  if result.code > 1 then
    return false, result.stderr
  end
  return true, result.stdout
end

local function cleanup(full)
  local lines = vim.split(full, "\n")
  local targets = {}
  local seen = {}
  for _,line in ipairs(lines) do
    local target, _ = line:match("^([%w_%-/]+):%s*(.*)")
    if target and target ~= "Makefile" then
      if not seen[target] then
        seen[target] = true
        table.insert(targets,target)
      end
    end
  end
  return targets
end

local function get_targets()
  local ok, out = run_cmd("make -qp -f Makefile")
  if not ok then
    return {""}
  end
  local  targets = cleanup(out)
  return targets
end

local function make(target)
  local cmd = "make "..target
  local ok, error_msg  = run_cmd(cmd)
  if not ok then
    vim.notify("error running make ->"..error_msg, vim.log.levels.ERROR)
    return
  end
  vim.notify("make "..target.." Succeded",vim.log.levels.INFO)
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
