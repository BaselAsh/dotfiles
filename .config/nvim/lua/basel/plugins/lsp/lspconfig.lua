-- ~/.config/nvim/lua/basel/plugins/lspconfig.lua
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -------------------------------------------------------------------------
        -- 🧩 General Setup
        -------------------------------------------------------------------------
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if cmp_ok then
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        end

        -- Diagnostic signs
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = signs.Error,
                    [vim.diagnostic.severity.WARN] = signs.Warn,
                    [vim.diagnostic.severity.HINT] = signs.Hint,
                    [vim.diagnostic.severity.INFO] = signs.Info,
                },
            },
        })

        -- for type, icon in pairs(signs) do
        --     local hl = "DiagnosticSign" .. type
        --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        -- end

        -- Diagnostic display configuration
        vim.diagnostic.config({
            virtual_text = { prefix = "●" },
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {

                border = "rounded",
                source = "always",
            },
        })

        -------------------------------------------------------------------------
        -- 🧠 Common LSP Keymaps
        -------------------------------------------------------------------------
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local opts = { buffer = event.buf, silent = true }

                -- LSP actions
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>fz", function()
                    vim.lsp.buf.format({ async = false })
                end, opts)

                -- Diagnostics
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

                -- Autoformat On Save
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = event.buf,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end,
        })

        -------------------------------------------------------------------------
        -- 🧱 Language Servers
        -------------------------------------------------------------------------

        -- Helper function to get Python path
        local function get_python_path(workspace)
            -- 1. Check for venv in workspace folder
            for _, pattern in ipairs({ "venv", ".venv", "env", ".env" }) do
                local python_path = workspace .. "/" .. pattern .. "/bin/python"
                if vim.fn.executable(python_path) == 1 then
                    return python_path
                end
            end
            -- 2. Fallback to system python
            return vim.fn.exepath("python3") or "python"
        end

        local function start_server(name, opts)
            local root = opts.root_files or {}
            opts.capabilities = capabilities
            opts.root_dir = vim.fs.dirname(vim.fs.find(root, { upward = true })[1])
            vim.lsp.start(vim.tbl_extend("force", { name = name, cmd = { name } }, opts))
        end

        -- Python
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            callback = function()
                local root_dir =
                    vim.fs.dirname(vim.fs.find({ "pyproject.toml", "setup.py", ".git" }, { upward = true })[1])
                start_server("pylsp", {
                    cmd = { "/home/baselash/.config/nvim/venv/bin/python", "-m", "pylsp" },
                    root_files = { "pyproject.toml", "setup.py", ".git" },
                    settings = {
                        pylsp = {
                            plugins = {
                                pycodestyle = { maxLineLength = 100 },
                                pyflakes = { enabled = true },
                                black = { enabled = true },
                            },
                        },
                    },
                })
            end,
        })

        -- C / C++
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "c", "cpp" },
            callback = function()
                start_server("clangd", { root_files = { "compile_commands.json", ".git" } })
            end,
        })

        -- JavaScript / TypeScript
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
            callback = function()
                start_server("typescript-language-server", {
                    cmd = { "typescript-language-server", "--stdio" },
                    root_files = { "package.json", "tsconfig.json", ".git" },
                    single_file_support = true,
                })
            end,
        })

        -- HTML / Django
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
            pattern = "*.html",
            callback = function()
                vim.bo.filetype = "htmldjango"
            end,
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "html", "htmldjango" },
            callback = function()
                start_server("vscode-html-language-server", {
                    cmd = { "vscode-html-language-server", "--stdio" },
                    root_files = { "index.html", ".git" },
                })
            end,
        })

        -- Lua (Neovim config)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "lua",
            callback = function()
                start_server("lua-language-server", {
                    root_files = { ".luarc.json", ".git" },
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                        },
                    },
                })
            end,
        })
    end,
}
