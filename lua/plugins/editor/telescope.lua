return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim"},
	keys = {
		{"<leader>,", "<cmd>Telescope buffers sort_mru=true sortlastused=true<cr>", desc="Switch buffer"},
		{"<leader>ff", "<cmd>Telescope find_files<cr>", desc="find files"},
		{"<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key maps"}
	}
}
