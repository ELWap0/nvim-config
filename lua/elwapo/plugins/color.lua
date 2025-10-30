local themes = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opt = {
      transparent_background = true,
    }
  },
  {
	  "bluz71/vim-moonfly-colors",
	  name = "moonfly",
	  lazy = true,

  },
  {
    "ntk148v/habamax.nvim",
	  name = "habamax",
	  lazy = true,
    dependencies={ "rktjmp/lush.nvim" },
  },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = true,
    opts = {
      transparent = true,
    },
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    lazy = true,
    opts = {
      style= "warmer",
      transparent = true,
    }

  }
}


return themes
