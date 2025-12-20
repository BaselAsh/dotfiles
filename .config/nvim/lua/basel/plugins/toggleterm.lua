return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        require('toggleterm').setup({
            -- NOTE: Change this to 'float' if you prefer a floating window
            -- direction = 'vertical',
            -- Size (height or width) of the terminal split
            size = 10,
            -- Determines if the terminal window stays open when switching buffers
            open_mapping = [[<C-/>]], -- Recommended keymap to toggle the terminal
            hide_numbers = true,      -- Hide the line numbers
            close_on_exit = true,     -- Close the terminal window when the shell exits
            start_in_insert = true,   -- Start in Insert Mode when opened
            -- Defines a default set of settings for each terminal window
            -- This ensures your terminal background is always dark for contrast
            win_opts = {
                winblend = 0,
                float_opts = {
                    border = 'curved',
                },
            },
        })

        -- Optional: Define a simple keymap in Normal Mode to open/close the terminal
        -- This uses the mapping defined above: <C-/> (Control + /)
        vim.keymap.set("n", "<C-/>", "<cmd>ToggleTerm<cr>", {
            noremap = true,
            silent = true,
            desc = "Toggle Terminal (vertical split)"
        })

        -- Optional: Define a terminal for running Git-related commands
        -- You can open this specific terminal with :ToggleTerm size=5 direction=float cmd=lazygit_or_htop_or_etc
        local Terminal = require('toggleterm.terminal').Terminal
        local git_term = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            hidden = true,
            count = 2, -- Use 2 so it doesn't conflict with the default (count=1)
            float_opts = {
                border = "double",
            },
        })

        function _G.toggle_lazygit()
            git_term:toggle()
        end

        -- Keymap for Lazygit (or any other tool you prefer, like htop)
        vim.keymap.set("n", "<leader>gL", "<cmd>lua _G.toggle_lazygit()<cr>", {
            noremap = true,
            silent = true,
            desc = "Toggle Lazygit"
        })
    end,
}
