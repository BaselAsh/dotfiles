return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local nvimtree = require("nvim-tree")

        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- Define the on_attach function to handle tree-specific keymaps
        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- Custom mappings for changing root
            vim.keymap.set("n", "l", api.tree.change_root_to_node, opts("CD Inwards"))
            vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts("CD Outwards"))
            vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD Inwards"))
        end

        nvimtree.setup({
            on_attach = my_on_attach, -- Add this line
            sync_root_with_cwd = true, -- Optional: Keeps CWD and Tree Root in sync
            view = {
                width = 35,
                relativenumber = true,
            },
            renderer = {
                indent_markers = {
                    enable = true,
                },
                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                        },
                    },
                },
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            filters = {
                custom = { ".DS_Store" },
            },
            git = {
                ignore = false,
            },
        })

        local keymap = vim.keymap
        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
        keymap.set(
            "n",
            "<leader>ef",
            "<cmd>NvimTreeFindFileToggle<CR>",
            { desc = "Toggle file explorer on current buffer" }
        )
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
    end,
}
