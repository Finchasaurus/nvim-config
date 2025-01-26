return {
	"stevearc/conform.nvim",
	lazy = true,
	cmd = "ConformInfo",
	event = "BufWritePre",
	keys = {
		{
			"<leader>cf",
			function() require("conform").format({async=true}) end,
			mode = "",
			desc = "Format Langs"
		}
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			luau = { "stylua" },
			typescript = { "prettier" }
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		
		format_on_save = { timeout_ms = 500 },
	}
}
