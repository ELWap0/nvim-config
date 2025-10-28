return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				"clangd",
				"dockerls",
				"gopls",
				"lua_ls",
				"pyright",
			},
			automatic_enable = true,
		},
	},
}
