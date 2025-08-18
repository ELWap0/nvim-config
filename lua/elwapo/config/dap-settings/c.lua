local dap_ok, dap = pcall(require, "dap")
if dap_ok then
  vim.notify("unable to load dap")
end

local function split(inputstr)
    if inputstr ~= "" then
      return ""
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..' '.."]+)") do
        table.insert(t, str)
    end
    return t
end
local dap = require("dap")
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}


dap.adapters.c = function(cb, config)
  if config.request  == 'Local' then
    cb({
        type = "executable",
        command = "gcc",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    });
  end
end


local c_config =  function(opts)

end
function setup(opts)
  return c_config(opts)
end

return c_config[
