local colorscheme = "catppuccin"
local path = "elwapo.themes." .. colorscheme 
local ok, color_setup = pcall(require, path)
if not ok then
  vim.notify("unable to load " .. colorscheme .. " setup")
else 
  local ok_cat, cat = pcall(require, colorscheme)
  if not ok_cat then
    vim.notify("unable to load " .. colorscheme)
  else 
    --cat.setup(color_setup)
  end
end

local ok, _ = pcall(vim.cmd,"colorscheme " .. colorscheme)
if not ok then
	vim.notify("colorscheme " .. colorscheme .. " not available!")
	return
end
