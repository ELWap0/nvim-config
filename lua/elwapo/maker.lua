local function run_cmd(cmd)
  local args = type(cmd) == "string" and vim.split(cmd, "%s+") or cmd
  local proc = vim.system(args, { text = true })
  local result = proc:wait()
  if result.code > 1 then
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

local function cleanup(full)
  local lines = vim.split(full, "\n")
  local targets = {}
  local seen = {}
  for _,line in ipairs(lines) do
    local target, _ = line:match("^([%w_%-/]+):%s*(.*)")
    if target and target ~= "Makefile" then
      if not seen[target] then
        vim.notify(target)
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
    vim.notify("error: "..out)
    return
  end
  local  targets = cleanup(out)
  return targets
end

--local function get_targets(arg_lead,cmd_line, cursor_pos)
--  local cmd = "make -pRrq -f Makefile : 2>/dev/null"
--  local ok, targets = run_cmd(cmd)
--  if not ok then
--    vim.notify("unable to get make targets -> " .. targets, vim.log.levels.WARN)
--    return {}
--  end
--  targets = cleanup(targets)
--  vim.notify(targets)
--  local results = {"one" , "two" , "three"}
--  return results
--end

local function make(target)
  local cmd = "make "..target
  local ok, error_msg  = run_cmd(cmd)
  if not ok then
    vim.notify("error running make ->"..error_msg, vim.log.levels.ERROR)
    return
  end
  vim.notify("make "..target.." Succeded",vim.log.levels.Info)
end

--vim.api.nvim_create_user_command("NMaker",
--function(opts)
--  local target = opts.args
--  make(target)
--end, {nargs = '?',
--      complete = get_targets})
--
--local M = {}
--M.make = make
--return M
get_targets()
