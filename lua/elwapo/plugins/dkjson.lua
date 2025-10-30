return {
	"LuaDist/dkjson",
	lazy = false,
	config = function()
		package.path = package.path .. ";" .. vim.fn.stdpath("data") .. "/lazy/dkjson/?.lua"
	end,
}
