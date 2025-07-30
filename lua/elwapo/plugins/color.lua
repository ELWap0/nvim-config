moonfly =  { 
	"bluz71/vim-moonfly-colors", 
	name = "moonfly", 
	lazy = false, 
	priority = 1000,
}

catppuccin = { 
  "catppuccin/nvim", 
  name = "catppuccin",
  priority = 1000,
  lazy = false,
}

habamax = { 
  "ntk148v/habamax.nvim", 
	name = "habamax", 
	lazy = false, 
	priority = 1000,
  dependencies={ "rktjmp/lush.nvim" } 
}


return habamax 
