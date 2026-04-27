-- coc.nvim 用の設定
local keyset = vim.keymap.set
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
-- Tabで補完選択
keyset("i", "<TAB>", function()
    if vim.fn["coc#pum#visible"]() == 1 then
        return vim.fn["coc#pum#next"](1)
    end
    return "<TAB>"
end, opts)

-- Enterで確定
keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

local opts = { silent = true }

-- Go to definition
keyset("n", "gd", "<Plug>(coc-definition)", opts)

-- Go to type definition
keyset("n", "gy", "<Plug>(coc-type-definition)", opts)

-- Go to implementation
keyset("n", "gi", "<Plug>(coc-implementation)", opts)

-- Go to references (shows a list of where the symbol is used)
keyset("n", "gr", "<Plug>(coc-references)", opts)

-- Show documentation in a floating window (K)
function _G.show_docs()
    local cw = vim.fn.expand("<cword>")
    if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command("h " .. cw)
    elseif vim.fn["coc#rpc#ready"]() then
        vim.fn.CocActionAsync("doHover")
    else
        vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
    end
end
keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", opts)

vim.g.coc_global_extensions = {
    "coc-clangd",
    "coc-json",
    "coc-html", -- HTML support
    "coc-emmet", -- Emmet support
    "coc-pyright", -- Python support
}
