return {
    -- 🔧 Formatting
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("conform").setup({
                format_on_save = {
                    timeout_ms = 5000,
                    lsp_fallback = true,
                },
                formatters_by_ft = {
                    python = { "black", "ruff_fix", "ruff_format" },
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
            })
        end,
    },

    -- 🧹 Linting
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
