return {
  { 
    "mason-org/mason.nvim",
    lazy=false,
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy=false,
    opts = {
      ensure_installed = { 
        "lua_ls",
      },
      automatic_enable = true
    }
  }
}
