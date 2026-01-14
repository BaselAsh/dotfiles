return {
    -- Formatting
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("conform").setup({
                format_on_save = function(bufnr)
                    if vim.g.disable_autoformat then
                        return
                    end
                    return { timeout_ms = 5000, lsp_fallback = true, quiet = true }
                end,
                formatters_by_ft = {
                    python = { "ruff_format", "ruff_fix", "black" },
                    lua = { "stylua" },
                    c = { "clang_format" },
                    cpp = { "clang_format" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    html = { "prettier" },
                    css = { "prettier" },
                    json = { "prettier" },
                },
                formatters = {
                    prettier = {
                        prepend_args = { "--single-quote", "true" },
                    },
                    black = {
                        prepend_args = { "--fast" },
                    },
                },
            })
            vim.api.nvim_create_user_command("FormatToggle", function()
                vim.g.disable_autoformat = not vim.g.disable_autoformat
                print("Autoformat-on-save: " .. (vim.g.disable_autoformat and "Disabled" or "Enabled"))
            end, {
                desc = "Toggle autoformat-on-save",
            })
        end,
    },

    -- Linting
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                python = { "ruff" },
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                -- ✅ Replaced clang_check with clangtidy
                c = { "clangtidy" },
                cpp = { "clangtidy" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
