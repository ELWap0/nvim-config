local blink_ok, blink = pcall(require,"blink.cmp")
if not blink_ok then
  vim.notify("unable to load blink.cmp")
  return {}
end
local M = {
        root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
        capabilities = blink.get_lsp_capabilities(),
        cmd = {'clangd', '--background-index', '--clang-tidy'},
        init_options = {
            fallbackFlags = { '-std=c++17' },
        },
        filetypes = {'c', 'cpp', 'objc', 'objcpp', 'cuda', 'hpp', 'h'},
}
return M
