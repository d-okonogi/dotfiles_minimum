local status, _ = pcall(vim.cmd.colorscheme, "nightfox")

if not status then
    vim.cmd.colorscheme("default")
    vim.opt.background = "dark"
end
