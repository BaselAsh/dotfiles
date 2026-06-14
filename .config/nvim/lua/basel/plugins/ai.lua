return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        { "stevearc/dressing.nvim", opts = {} },
    },
    opts = {
        strategies = {
            chat = { adapter = "ollama" },
            inline = { adapter = "ollama" },
            cmd = { adapter = "ollama" },
        },

        -- BYPASS THE BUG: Turn off the plugin's broken markdown crawler
        prompt_library = {
            builtin = false,
        },

        -- Explicitly define a clean, working action list for <leader>ai
        -- This keeps the action palette working perfectly without indexing nil values
        actions = {
            validate = false, -- Stops strict background validation loops
        },

        adapters = {
            ollama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    schema = {
                        model = {
                            default = "qwen2.5-coder:1.5b",
                        },
                        num_ctx = {
                            default = 4096,
                        },
                        temperature = {
                            default = 0.2,
                        },
                    },
                })
            end,
        },

        display = {
            chat = {
                show_tokens = true,
                window = {
                    layout = "vertical",
                    width = 45,
                },
            },
        },
    },
    config = function(_, opts)
        require("codecompanion").setup(opts)

        -- Toggle the main side chat assistant (Works perfectly with #buffer)
        vim.keymap.set({ "n", "v" }, "<leader>ac", function()
            require("codecompanion").toggle()
        end, { desc = "Toggle AI Chat Window" })

        -- Clean Inline AI Prompts (Bypasses the broken palette window)
        vim.keymap.set({ "n", "v" }, "<leader>ai", function()
            -- Calls CodeCompanion's direct inline interface instead of the action explorer
            require("codecompanion").inline()
        end, { desc = "Run Inline AI Prompt" })

        -- Visually select a block of code and append it straight to your context
        vim.keymap.set("v", "<leader>aa", function()
            require("codecompanion").add()
        end, { desc = "Append Selection to AI Context" })
    end,
}
