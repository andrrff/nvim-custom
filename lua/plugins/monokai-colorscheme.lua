return {
    {
        "tanvirtin/monokai.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("monokai").setup({
                palette = require("monokai").soda,
                transparent = true,
            })

            vim.cmd([[colorscheme monokai]])
            vim.defer_fn(function()
                vim.cmd([[
                    hi Normal guibg=none ctermbg=none
                    hi LineNr guibg=none ctermbg=none
                    hi SignColumn guibg=none ctermbg=none
                    hi CursorLineNr guibg=none ctermbg=none
                    hi Visual guibg=#5F5A60
                ]])
            end, 100)
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "monokai"
        },
    },
}
