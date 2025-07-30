local lz_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lz_path) then
	local lz_repo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lz_repo, lz_path})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{"Failed to clone lazy.nvim:\n", "ErrorMsg"},
			{out, "WarningMsg" },
			{"\nPress any key to exit..."},
		},true,{})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lz_path)

vim.g.mapleader = ""
vim.g.maplocalleader = "\\"

require("lazy").setup({
	spec = "elwapo.plugins",
	checker = { enabled = true },
  	change_detection = { notify = true }
})

