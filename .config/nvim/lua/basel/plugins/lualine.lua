return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        local colors = {
            blue = "#7FBBB3",
            green = "#FF61EF",
            violet = "#D699B6",
            yellow = "#D8A657",
            red = "#E67E80",
            fg = "#D3C6AA",
            bg = "#2B3339",
            inactive_bg = "#2B3339",
        }

        local my_lualine_theme = {
            normal = {
                a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            insert = {
                a = { bg = colors.green, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            visual = {
                a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            command = {
                a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            replace = {
                a = { bg = colors.red, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            inactive = {
                a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.semilightgray },
                c = { bg = colors.inactive_bg, fg = colors.semilightgray },
            },
        }

        -- configure lualine with modified theme
        lualine.setup({
            options = {
                theme = my_lualine_theme,
            },
            sections = {
                lualine_y = {
                    {
                        function()
                            local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
                            if venv then
                                -- Get the name of the venv (last part of the path)
                                return " " .. vim.fn.fnamemodify(venv, ":t") --  is a Python icon
                            end
                            return '' -- Return empty string if no venv is active
                        end,
                        -- Apply your custom color (using 'blue' for foreground and a dark background)
                        color = { fg = colors.blue, gui = 'bold' },
                        cond = function()
                            -- Only show if a venv is detected AND we are in a Python filetype buffer
                            local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
                            return venv ~= nil and (vim.bo.filetype == 'python' or vim.bo.filetype == 'djangohtml')
                        end,
                    },
                },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                    { "search.vc.branch", icon = "" }
                },
            },
        })
    end,
}
