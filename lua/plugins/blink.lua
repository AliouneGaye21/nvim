-- lua/plugins/blink.lua
return {
    'saghen/blink.cmp',
    -- 'dependencies' assicura che questi plugin vengano caricati prima o insieme a blink.cmp
    dependencies = {

        'hrsh7th/nvim-cmp',
        'rafamadriz/friendly-snippets',
        'giuxtaposition/blink-cmp-copilot', -- Il "ponte" per integrare Copilot
        'zbirenbaum/copilot.lua',           -- È buona norma dichiarare la dipendenza esplicita

        -- dipendenze che erano in nvim-cmp.lua
        "hrsh7th/cmp-buffer",       -- Fonte per il completamento dal buffer corrente
        "hrsh7th/cmp-path",         -- Fonte per il completamento dei percorsi file
        "L3MON4D3/LuaSnip",         -- Motore degli snippet
        "saadparwaiz1/cmp_luasnip", -- È buona norma dichiarare la dipendenza esplicita
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
                Keyword = '󰌋',
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
            documentation = {
                auto_show = true, -- Abilita la finestra di documentazione
                win_options = {
                    -- Opzioni per la finestra popup, per un look più moderno
                    border = "rounded",
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                }
            }
        },

        sources = {
            -- Aggiungi 'copilot' all'elenco delle fonti. L'ordine è importante!
            -- Mettilo dopo 'lsp' e 'snippets' ma prima di altri per una buona priorità.
            default = { 'lsp', 'snippets', 'copilot', 'path', 'buffer' },
            providers = {
                lsp = {
                    priority = 100, -- Massima priorità ai suggerimenti del Language Server
                },
                snippets = {
                    priority = 90, -- Subito dopo vengono gli snippets
                },
                buffer = {
                    priority = 50, -- I suggerimenti dal buffer hanno una priorità molto più bassa
                },
                path = {
                    priority = 70, -- I percorsi sono più importanti del buffer ma meno di altro
                },
                -- Qui configuri come 'blink.cmp' deve trattare la fonte 'copilot'
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot", -- Specifica il plugin bridge
                    priority = 80,                -- Dagli una priorità alta per farlo apparire prima
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
