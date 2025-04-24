return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.popup_border_style = "rounded"
    opts.window = {
      position = "float",
      popup = {
        title = "Explorer",
      },
    }
  end,
}
