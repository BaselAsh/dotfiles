return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "neovim/nvim-lspconfig",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        -- Load vscode-style snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Setup nvim-cmp
        cmp.setup({
            completion = { completeopt = "menu,menuone,preview,noselect" },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
        })

        --------------------------------------------------------------------
        -- ✅ New API for LSP (Neovim 0.11+)
        --------------------------------------------------------------------
        if not vim.lsp.config.html then
            vim.lsp.configs.html = {
                default_config = {
                    cmd = { "vscode-html-language-server", "--stdio" },
                    filetypes = { "html", "htmldjango" },
                    root_dir = vim.fs.dirname(vim.fs.find({ ".git", "package.json" }, { upward = true })[1]),
                },
            }
        end

        -- Start HTML/Django LSP automatically
        vim.api.nvim_create_autocmd({ "FileType" }, {
            pattern = { "html", "htmldjango" },
            callback = function()
                vim.lsp.start(vim.lsp.configs.html.default_config)
            end,
        })

        -- Automatically set *.html to htmldjango for Django templates
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
            pattern = "*.html",
            callback = function()
                vim.bo.filetype = "htmldjango"
            end,
        })
    end,
}
