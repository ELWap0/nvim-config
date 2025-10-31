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
    end,
    keys = {
      {
        "<leader>ds",
        function()
          require("dap").continue()
        end,
        desc = "Dap start",
        mode = "n",
        silent = true,
      },
      {
        "<leader>dt",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Dap toggle break",
        mode = "n",
        silent = true,
      },
      {
        "<leader>dd",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "Dap clear break",
        mode = "n",
        silent = true,
      },
      {
        "<leader>de",
        function()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.close()
          dap.terminate()
          dap.repl.close()
          dap.clear_breakpoints()
          dap.disconnect()
          if dap.session() then
            dap.session().close()
          end
        end,
        desc = "Dap end",
        mode = "n",
        silent = true,
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Dap continue",
        mode = "n",
        silent = true,
      },
    }
  }
}
