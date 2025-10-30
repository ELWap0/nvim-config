return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    "nvim-telescope/telescope-fzf-native.nvim",
    "sharkdp/fd",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local tele_config_ok, tele_config = pcall(require, "elwapo.config.telescope")
    if not tele_config_ok then
      vim.notify("unable to load telescope config")
    end
    require("telescope").setup(tele_config)
  end,
  keys = {
    {"<leader>te", "<cmd>Telescope<cr>"},
    {"<leader>tf", "<cmd>Telescope find_file<cr>"},
    {"<leader>tg", "<cmd>Telescope live_grep<cr>"}
  }

}
