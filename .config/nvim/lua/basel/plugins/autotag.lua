return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"https://github.com/nvim-treesitter/nvim-treesitter/",
	},
	config = function()
		local autotag = require("nvim-ts-autotag")
		autotag.setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
			filetypes = { "html", "htmldjango", "javascript", "jsx" },
		})
	end,
}
