return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
      local ok, lua_opt = pcall(require,"elwapo.config.lualine")
      if not ok then
        vim.notify("unable to load lualine config")
      end
      vim.notify("lua start")
      return lua_opt
    end,
}
