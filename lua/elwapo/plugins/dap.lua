return {
  {
  "mfussenegger/nvim-dap",
  cmd = { "DapNew", "DapToggleBreakpoint" },
  dependencies = { "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    require("dapui").setup()
    local dap_config_ok, _ = pcall(require, "elwapo.config.dap")
    if not dap_config_ok then
      vim.notify("unable to load dap config")
      return
    end
  end
  }
}
