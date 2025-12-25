return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
        -- Basic configuration
        heading = {
            sign = true,
            icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        },
        checkbox = {
            enabled = true,
            unchecked = { icon = "󰄱 " },
            checked = { icon = " " },
        },
    },
}
