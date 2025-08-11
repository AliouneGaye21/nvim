return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                highlight = {
                    enable = true,
                },
                indent = { enable = true },
                autotag = { enable = true },
                fold = { enable = true },
                ensure_installed = {
                    "json",
                    "javascript",
                    "query",
                    "typescript",
                    "tsx",
                    "php",
                    "yaml",
                    "html",
                    "css",
                    "markdown",
                    "markdown_inline",
                    "bash",
                    "lua",
                    "vim",
                    "vimdoc",
                    "c",
                    "dockerfile",
                    "gitignore",
                    "astro",
                    "elixir",
                },
                auto_install = false,
            })

            -- 👉 Imposta il folding TreeSitter
            local opt = vim.opt
            opt.foldmethod = "expr"
            opt.foldexpr = "nvim_treesitter#foldexpr()"
            opt.foldenable = true
            opt.foldlevel = 20
            opt.foldcolumn = "1"
            opt.fillchars:append({ fold = " " })
        end
    },


    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            local rainbow_delimiters = require 'rainbow-delimiters'
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    vim = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }

            -- 🎨 Colori in armonia con vscode.nvim
            local colors = {
                Red    = "#D16969",
                Yellow = "#DCDCAA",
                Blue   = "#569CD6",
                Orange = "#CE9178",
                Green  = "#6A9955",
                Violet = "#C586C0",
                Cyan   = "#4EC9B0",
            }

            for name, hex in pairs(colors) do
                vim.api.nvim_set_hl(0, "RainbowDelimiter" .. name, { fg = hex, bg = "none" })
            end
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowBlockRed", { fg = "#D16969", bg = "none" })
                vim.api.nvim_set_hl(0, "RainbowBlockYellow", { fg = "#DCDCAA", bg = "none" })
                vim.api.nvim_set_hl(0, "RainbowBlockBlue", { fg = "#569CD6", bg = "none" })
                vim.api.nvim_set_hl(0, "RainbowBlockOrange", { fg = "#CE9178", bg = "none" })
                vim.api.nvim_set_hl(0, "RainbowBlockGreen", { fg = "#6A9955", bg = "none" })
                vim.api.nvim_set_hl(0, "RainbowBlockViolet", { fg = "#C586C0", bg = "none" })
                vim.api.nvim_set_hl(0, "RainbowBlockCyan", { fg = "#4EC9B0", bg = "none" })
            end)

            require("ibl").setup {
                scope = {
                    enabled = true,
                    highlight = {
                        "RainbowBlockRed",
                        "RainbowBlockYellow",
                        "RainbowBlockBlue",
                        "RainbowBlockOrange",
                        "RainbowBlockGreen",
                        "RainbowBlockViolet",
                        "RainbowBlockCyan",
                    }
                }
            }
        end,
    },

    {
        "nvim-treesitter/playground",
        cmd = { "TSPlaygroundToggle" }, -- carica il plugin solo quando esegui il comando
        config = function()
            require("nvim-treesitter.configs").setup({
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- ms
                    persist_queries = false,
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?',
                    },
                },
            })
        end,
    },

}
