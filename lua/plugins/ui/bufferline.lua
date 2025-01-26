return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "echansnovski/mini.icons", "tiagovla/scope.nvim" },
	keys = {
		{ "<leader>br", "<cmd>BufferLineCloseRight", desc = "Close buffers to the right" },
		{ "<leader>bl", "<cmd>BufferLineCloseLeft", desc = "Close buffers to the left" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
	},
	opts = {},
	config = function(_, opts)
		require("bufferline").setup(opts)
	end,
}
