return {
  "mfussenegger/nvim-dap",
  cmd = {"DapNew", "DapToggleBreakpoint"},
  dependencies = {"rcarriga/nvim-dap-ui",
                   "nvim-neotest/nvim-nio",
                   "theHamsta/nvim-dap-virtual-text",
                  },
  config = function()
    local dap_config_ok, dap_config = pcall(require,"elwapo.config.dap")
    if not dap_config_ok then
      vim.notify("unable to load dap config")
      return
    end
    dap_config.setup()
  end
}
