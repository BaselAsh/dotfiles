return {
	"rebelot/kanagawa.nvim",
	version = false,
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			-- My config here
			undercurl = true,
			commandStyle = { italic = true },
			colors = {
				palette = {},
				themes = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			theme = "dragon",
		})
		vim.cmd("colorscheme kanagawa-dragon")
	end,
}
