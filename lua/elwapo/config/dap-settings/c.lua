local dap_ok, dap = pcall(require, "dap")
if dap_ok then
  vim.notify("unable to load dap")
end

dap.adapters.c = function(cb, config)
  if config.request  == 'local' then
    cb({
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    });
  elseif config.request == 'remote' then
    cb({
      type = "",
      command = "",
      args = ""
    });
  end
end


local function c_config(opts)
   local  config  = {
      name = "debug",
      type = opts.type or "gdb",
      request = opts.request or 'local',
      program = opts.project or "${fileDirname}",
      cwd = opts.cwd or "${workspaceFolder}",
    }

    if opts.args ~= nil then
      config.args = opts.args
    end
    if opts.target ~= nil then
      config.target = opts.target
      config.gdbTarget = "localhost:3333"
      config.setupCommands = {
        {text = "target remote localhost:3333"},
        {text = "monitor reset halt"},
        {text = "load"},
      }
    end
    return config
end

function Setup(opts)
  if opts.build == "true" then
     local res = require("elwapo.maker").make(opts.project)
     if not res then
       return false, {}
     end
  end
  if opts.target ~= nil then
    local res = require("elwapo.maker").make("debug")
    if not res then
      return false, {}
    end
  end
  return true, c_config(opts)
end

