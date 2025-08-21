return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-project.nvim", -- <--- estensione project
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup {
            -- qui puoi mettere la tua configurazione di telescope
        }
        -- carica l'estensione project
        telescope.load_extension("project")
    end
}
