return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'saghen/blink.cmp',
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        local autoformat_filetypes = { "elixir", "heex", "exs", "ts", "js", "lua" }
        local lspconfig = require('lspconfig')


        local capabilities = {
            textDocument = {
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true
                }
            }
        }

        -- ✅ Base capabilities da blink.cmp
        capabilities = require('blink.cmp').get_lsp_capabilities()


        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then return end
                if vim.tbl_contains(autoformat_filetypes, vim.bo[args.buf].filetype)
                    and client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = args.buf })
                        end
                    })
                end
            end
        })

        -- Mason setup
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                "lua_ls",
                "intelephense",
                "ts_ls",
                "eslint",
                "elixirls",
                "sqls",
                "dockerls",
                "docker_compose_language_service",
                "yamlls",
                "tailwindcss",
            },
            handlers = {
                -- default handler: passa le capabilities a tutti
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                -- lua custom config
                lua_ls = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "LuaJIT" },
                                diagnostics = { globals = { "vim" } },
                                workspace = { library = { vim.env.VIMRUNTIME } },
                            },
                        },
                    })
                end,
                -- elixir custom config
                elixirls = function()
                    lspconfig.elixirls.setup({
                        capabilities = capabilities,
                        settings = {
                            elixirLS = {
                                dialyzerEnabled = true,
                                fetchDeps = false,
                                enableTestLenses = false,
                            }
                        }
                    })
                end,
                -- sql custom config
                sqls = function()
                    lspconfig.sqls.setup({
                        capabilities = capabilities,
                        settings = {
                            sqls = {
                                connections = {
                                    {
                                        driver = "postgresql",
                                        dataSourceName =
                                        "postgres://postgres:postgres@localhost:5432/mydb?sslmode=disable",
                                    },
                                },
                            },
                        },
                    })
                end,
            },
        })

        -- ✨ Hover window con bordo
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = "rounded" }
        )

        -- ✨ Diagnostica
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = { border = "rounded" },
        })

        -- ✨ Keymaps standard LSP
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    end
}
