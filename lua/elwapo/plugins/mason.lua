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
				"black",
				"clang-format",
				"clangd",
				"dockerls",
				"goimports",
				"gopls",
				"isort",
				"lua_ls",
				"pyright",
				"stylua",
			},
			automatic_enable = true,
		},
	},
}
