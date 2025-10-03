local capabilities = require("blink.cmp").get_lsp_capabilities()
-- Intelephense: completions, hover, diagnostics, symbols
vim.lsp.config.intelephense = {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	capabilities = capabilities,
	root_markers = { ".git", "composer.json" },
	on_attach = function(client)
		-- disable workspace symbols if you want Phpactor to handle them
		client.server_capabilities.workspaceSymbolProvider = false
	end,
	settings = {
		intelephense = {
			environment = {
				phpVersion = "8.3",
			},
			-- completion = {
			-- 	callSnippet = "Replace",
			-- 	insertFullyQualifiedNames = false, -- show FQN in menu, insert short name
			-- 	fullyQualifyGlobalConstantsAndFunctions = true,
			-- },
		},
	},
}

vim.lsp.enable("intelephense")
