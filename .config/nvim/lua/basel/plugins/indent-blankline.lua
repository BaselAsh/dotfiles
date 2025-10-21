return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadpre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { char = "┊" },
  },
}
