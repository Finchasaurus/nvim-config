return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"echasnovski/mini.icons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		popup_border_style = "rounded",
		window = {
			position = "float",
		},
	},
}
