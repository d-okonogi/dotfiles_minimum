require("base")
require("autocmds")
require("options")
require("colorscheme")
require("plugins")
require("keymaps")
require("coc")
-- Plugin configurations
require("oil").setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
        natural_sorting = true,
    },
    float = {
        padding = 2,
        max_width = 0.9,
        max_height = 0.9,
        border = "rounded",
        win_options = {
            winblend = 10,
        },
    },
    keymaps = {
        ["<C-h>"] = "actions.parent",
        ["<leader>|"] = "actions.select_vsplit",
        ["<leader>-"] = "actions.select_split",
        ["<leader>t"] = "actions.select_tab",
        ["<C-r>"] = "actions.refresh",
        ["q"] = "actions.close",
    },
})
-- lua/mason-config.lua
require("mason").setup({
    ui = {
        border = "rounded",
    },
})

require("mason-tool-installer").setup({
    -- List of tools to be automatically installed
    ensure_installed = {
        "stylua", -- Lua formatter
        "shfmt", -- Shell formatter
        "black", -- Python formatter
        "pyright", -- Python LSP
        "clang-format", -- C/C++ formatter
        "html-lsp", -- HTML formatter
        "clangd", -- C/C++ Language Server (for coc or nvim-lsp)
    },

    -- Automatically update tools
    auto_update = true,
    -- Run installation on startup
    run_on_start = true,
})
