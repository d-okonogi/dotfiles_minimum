-- smart line start
vim.keymap.set({ "n", "x", "o" }, "0", function()
    return vim.v.count > 0 and "0" or "^"
end, { expr = true, desc = "0 => first non-blank (keep count)" })

-- absolute line start
vim.keymap.set({ "n", "x", "o" }, "<leader>0", "0", { desc = "Go to absolute line start" })

-- disable space cursor movement
vim.keymap.set({ "n", "x", "o" }, "<Space>", "<Nop>", { silent = true, desc = "Disable space cursor movement" })
vim.keymap.set("n", "<leader>e", require("oil").toggle_float, { desc = "Open Oil in a floating window" })

-- comment toggle
vim.keymap.set({ "n", "i" }, "<leader>/", function()
    require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
vim.keymap.set("x", "<leader>/", function()
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment" })

-- start of line with Ctrl+a, and end of line with Ctrl+e
vim.keymap.set({ "n", "i", "c" }, "<C-a>", "<Home>", { desc = "Move to start of line" })
vim.keymap.set({ "n", "i", "c" }, "<C-e>", "<End>", { desc = "Move to end of line" })

-- type jj to exit insert mode
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

--tab switch
vim.keymap.set("n", "<leader>l", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>h", ":tabprevious<CR>", { desc = "Previous tab" })
