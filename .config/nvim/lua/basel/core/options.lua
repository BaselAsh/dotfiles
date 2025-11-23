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

local indent_group = vim.api.nvim_create_augroup("FileTypeIndentSettings", { clear = true })


vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "djangohtml", "javascript", "typescript", "json", "dart", "ruby" },
    group = indent_group,
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
        vim.opt_local.autoindent = true
    end
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
