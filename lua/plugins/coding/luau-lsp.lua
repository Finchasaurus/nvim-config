local function rojo_project()
	return vim.fs.root(0, function(name)
		return name:match(".+%.project%.json$")
	end)
end

local function get_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
	capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
	return capabilities
end

return {
	"lopi-py/luau-lsp.nvim",
	ft = "luau",
	opts = function()
		local capabilities = get_capabilities()
		return {
			platform = {
				type = rojo_project() and "roblox" or "standard",
			},
			server = {
				capabilities = capabilities,
				settings = {
					["luau-lsp"] = {
						ignoreGlobs = { "**/__Index/**", "node_modules/**" },
						completion = {
							imports = {
								enabled = true,
								ignoreGlobs = { "**/_Index/**", "node_modules/**" },
							},
						},
						require = {
							mode = "relativeToFile",
							directoryAliases = require("luau-lsp").aliases(),
						},
						inlayHints = {
							functionReturnTypes = true,
							parameterTypes = true,
						},
					},
				},
			},
		}
	end,
}
