return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true, timeout = 3000 },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    },
    keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
        { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
        { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },

        -- File & Project Pickers
        { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
        { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
        { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
        { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent Files" },
        {
            "<leader>fp",
            function()
                local telescope = require("telescope")
                telescope.extensions.project.project({
                    on_project_selected = function(prompt_bufnr)
                        local actions = require("telescope._extensions.project.actions")
                        -- Cambia la working directory senza chiudere il picker
                        actions.change_working_directory(prompt_bufnr, false)
                    end
                })
            end,
            desc = "Projects"
        },

        -- Git
        { "<leader>gb", function() Snacks.picker.git_branches() end,        desc = "Git Branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end,             desc = "Git Log" },
        { "<leader>gs", function() Snacks.picker.git_status() end,          desc = "Git Status" },

        -- LSP
        { "gd",         function() Snacks.picker.lsp_definitions() end,     desc = "Goto Definition" },
        { "gr",         function() Snacks.picker.lsp_references() end,      desc = "Goto References" },
        { "gI",         function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end,         desc = "LSP Symbols" },

        -- Other
        { "<leader>z",  function() Snacks.zen() end,                        desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end,                   desc = "Toggle Zoom" },
        { "<leader>.",  function() Snacks.scratch() end,                    desc = "Toggle Scratch Buffer" },
        { "<leader>d",  "<cmd>lua require('snacks.dashboard').open()<cr>",  desc = "Open Dashboard" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Toggle options example
                Snacks.toggle.option("wrap"):map("<leader>uw")
                Snacks.toggle.option("relativenumber"):map("<leader>uL")
            end,
        })
    end,
}
