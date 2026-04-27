-- Common Utility Functions
local function exe(cmd)
    return vim.fn.executable(cmd) == 1
end

local function filter_with_view(cmdline, not_found_msg)
    local cmd = vim.split(cmdline, "%s+")[1]:gsub("%%!", "")
    if not exe(cmd) then
        vim.notify(not_found_msg, vim.log.levels.ERROR)
        return
    end

    local view = vim.fn.winsaveview()
    local ok, err = pcall(function()
        vim.cmd("silent keepjumps keepalt " .. cmdline)
    end)
    vim.fn.winrestview(view)

    if not ok then
        vim.notify("Format error: " .. tostring(err), vim.log.levels.ERROR)
    end
end

--------------------------------------------------------------------------------
-- 1. Auto-Formatter Configuration (AutoFormat)
--------------------------------------------------------------------------------
local fmt_group = vim.api.nvim_create_augroup("MyFormatters", { clear = true })

local formatters = {
    { pattern = "*.py", cmd = "%!black --quiet -", msg = "Error: 'black' not found. Install via: pip install black" },
    { pattern = { "*.sh", "*.bash", "*.zsh" }, cmd = "%!shfmt -i 2 -ci -bn -", msg = "Error: 'shfmt' not found." },
    { pattern = "*.lua", cmd = "%!stylua -", msg = "Error: 'stylua' not found." },
    { pattern = { "*.html", "*.htm" }, cmd = "%!tidy -q -i --indent-spaces 2 --wrap 0", msg = "Error: 'tidy' not found." },
    { pattern = { "*.c", "*.h", "*.cpp", "*.hpp" }, cmd = "%!clang-format -", msg = "Error: 'clang-format' not found." },
}

for _, fmt in ipairs(formatters) do
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = fmt_group,
        pattern = fmt.pattern,
        callback = function()
            filter_with_view(fmt.cmd, fmt.msg)
        end,
    })
end

--------------------------------------------------------------------------------
-- 2. General Pre-Save Hooks (MySavePre)
--------------------------------------------------------------------------------
local save_group = vim.api.nvim_create_augroup("MySavePre", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = save_group,
    pattern = "*",
    callback = function(event)
        -- a. Auto-create directory if it doesn't exist
        local dir = vim.fn.fnamemodify(event.match, ":h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end

        -- b. Convert tabs to spaces (excluding Makefiles)
        if vim.bo.filetype ~= "make" then
            local view = vim.fn.winsaveview()
            vim.cmd([[silent! retab]])
            vim.fn.winrestview(view)
        end
    end,
})

--------------------------------------------------------------------------------
-- 3. Buffer/Filetype Specific Settings (GeneralSettings)
--------------------------------------------------------------------------------
local general_group = vim.api.nvim_create_augroup("MyGeneral", { clear = true })

-- Disable comment continuation on new lines
vim.api.nvim_create_autocmd("BufEnter", {
    group = general_group,
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Makefile specific: Keep tabs
vim.api.nvim_create_autocmd("FileType", {
    group = general_group,
    pattern = "make",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

--------------------------------------------------------------------------------
-- 4. External File Change Detection (AutoRead)
--------------------------------------------------------------------------------
local autoread_group = vim.api.nvim_create_augroup("MyAutoRead", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermClose" }, {
    group = autoread_group,
    command = "checktime",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
    group = autoread_group,
    callback = function(args)
        local name = args.file ~= "" and vim.fn.fnamemodify(args.file, ":~:.") or "current buffer"
        vim.notify(("Reloaded: %s (changed externally)"):format(name), vim.log.levels.INFO)
    end,
})
