vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- Tabs & indentation
-- For most programming languages
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true

-- local indent_group = vim.api.nvim_create_augroup("FileTypeIndentSettings", { clear = true })

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "html", "css", "djangohtml", "javascript", "typescript", "json", "dart", "ruby" },
--     group = indent_group,
--     callback = function()
--         vim.opt_local.shiftwidth = 2
--         vim.opt_local.tabstop = 2
--         vim.opt_local.softtabstop = 2
--         vim.opt_local.expandtab = true
--         vim.opt_local.autoindent = true
--     end
-- })
--

-- Create a group so the autocmds don't duplicate on reload
local indent_group = vim.api.nvim_create_augroup("IndentSettings", { clear = true })

-- Helper function to set indentation
local function set_indent(size)
    vim.opt_local.tabstop = size
    vim.opt_local.shiftwidth = size
    vim.opt_local.expandtab = true
end

-- 2-space indentation for Web Development (PERN Stack)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css", "html" },
    group = indent_group,
    callback = function()
        set_indent(2)
    end,
})

-- 4-space indentation for Python and C++
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "cpp", "c" },
    group = indent_group,
    callback = function()
        set_indent(4)
    end,
})

opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- Colorschemes options
opt.winborder = "rounded"
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Splits windows
opt.splitright = true
opt.splitbelow = true

opt.scrolloff = 10

-- Remove ~ remove end of file buffer
opt.fillchars = { eob = " " }

-- Save undo_history
-- Enable persistent undo
local undodir = vim.fn.expand("~/.local/share/nvim/undo")

-- Create the directory if it doesn't exist
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p", 0700)
end

vim.opt.undodir = undodir
vim.opt.undofile = true
