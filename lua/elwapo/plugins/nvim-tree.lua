return {
  "nvim-tree/nvim-tree.lua",
  lazy=true,
  opts = function()
    local tree_ok, tree = pcall(require,"elwapo.config.nvim-tree")
    if not tree_ok then
      vim.notify("unable to load tree config")
    end
    return tree
  end,
  keys = {
    {"<leader>tt", "<cmd>NvimTreeToggle<cr>"}
  }
}
