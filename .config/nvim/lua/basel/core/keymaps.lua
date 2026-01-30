vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Quit" })
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save the current buffer" })

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Increment/Decrement numbers
keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Windows management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Windows navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to the lift buffer" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to the down buffer" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to the up buffer" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to the right buffer" })

-- Tabs management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close curret tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Moving line up or down
keymap.set("n", "<A-k>", "<cmd>m .-2<CR>", { desc = "Move line up" })
keymap.set("n", "<A-j>", "<cmd>m .1<CR>", { desc = "Move line down" })
keymap.set("i", "<A-k>", "<cmd>m .-2<CR>", { desc = "Move line up" })
keymap.set("i", "<A-j>", "<cmd>m .1<CR>", { desc = "Move line down" })

-- for markdown files
keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown Preview" })

-- launching live-server
keymap.set("n", "<leader>ls", "<cmd>TermExec cmd='live-server'<cr>", { desc = "Run Live Server" })

-- Toggle autoformatting
vim.keymap.set("n", "<leader>Ft", "<cmd>FormatToggle<CR>", { desc = "Toggle Format on Save" })

-- Toggle undotree with <leader>u
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undo Tree" })
