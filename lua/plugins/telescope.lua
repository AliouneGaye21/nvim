return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-project.nvim",
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup {
            extensions = {
                project = {
                    base_dirs = {
                        { "~/work/", max_depth = 3 },  -- directory principale con profondità massima di 3
                        -- { "~/astarte/", max_depth = 2 }, -- un'altra directory
                    },
                    hidden_files = false, -- mostra anche i file nascosti nei progetti
                    theme = "dropdown",
                    order_by = "recent",  -- ordina i progetti per ultimo utilizzo
                }
            }
        }

        -- carica l'estensione project
        telescope.load_extension("project")
    end
}
