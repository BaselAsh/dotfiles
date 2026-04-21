return {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("poimandres").setup({
            bold_vert_split = true,
            dim_nc_background = true,
            disable_background = false,
            disable_float_background = false,
            dark_variant = "main",
        })

        local hl = vim.api.nvim_set_hl
        -- 3. Strip all background colors from Markdown Headers
        local markdown_groups = {
            "markdownH1",
            "markdownH2",
            "markdownH3",
            "markdownH4",
            "@text.title.1.markdown",
            "@text.title.2.markdown",
            "@markup.heading.1.markdown",
            "@markup.heading.2.markdown",
        }

        for _, group in ipairs(markdown_groups) do
            hl(0, group, { bg = "none", force = true })
        end
    end,
}
