-- lua/plugins/blink.lua
return {
    'saghen/blink.cmp',
    -- 'dependencies' assicura che questi plugin vengano caricati prima o insieme a blink.cmp
    dependencies = {
        'rafamadriz/friendly-snippets',
        'giuxtaposition/blink-cmp-copilot', -- Il "ponte" per integrare Copilot
        'zbirenbaum/copilot.lua',           -- È buona norma dichiarare la dipendenza esplicita
    },
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'super-tab',
        },


        appearance = {
            nerd_font_variant = 'mono',
            kind_icons = {
                Copilot = "",
                Text = '󰉿',
                Method = '󰊕',
                Function = '󰊕',
                Constructor = '󰒓',
                Field = '󰜢',
                Variable = '󰆦',
                Property = '󰖷',
                Class = '󱡠',
                Interface = '󱡠',
                Struct = '󱡠',
                Module = '󰅩',
                Unit = '󰪚',
                Value = '󰦨',
                Enum = '󰦨',
                EnumMember = '󰦨',
                Keyword = '󰻾',
                Constant = '󰏿',
                Snippet = '󱄽',
                Color = '󰏘',
                File = '󰈔',
                Reference = '󰬲',
                Folder = '󰉋',
                Event = '󱐋',
                Operator = '󰪚',
                TypeParameter = '󰬛',
            },
        },

        completion = {
            documentation = { auto_show = false }
        },

        sources = {
            -- Aggiungi 'copilot' all'elenco delle fonti. L'ordine è importante!
            -- Mettilo dopo 'lsp' e 'snippets' ma prima di altri per una buona priorità.
            default = { 'lsp', 'snippets', 'copilot', 'path', 'buffer' },
            providers = {
                -- Qui configuri come 'blink.cmp' deve trattare la fonte 'copilot'
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot", -- Specifica il plugin bridge
                    -- score_offset = 90,            -- Dagli una priorità alta per farlo apparire prima
                    async = true,
                    -- Questa funzione è fondamentale per assegnare l'icona e il tipo "Copilot"
                    transform_items = function(_, items)
                        local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                        local kind_idx = #CompletionItemKind + 1
                        CompletionItemKind[kind_idx] = "Copilot"
                        for _, item in ipairs(items) do
                            item.kind = kind_idx
                        end
                        return items
                    end,
                },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
    },

    opts_extend = { "sources.default" },

    config = function(_, opts)
        require("blink.cmp").setup(opts)

        vim.keymap.set("i", "<leader>cp", require("blink.cmp").show, {
            desc = "Blink: Mostra suggerimenti",
        })
    end
}
