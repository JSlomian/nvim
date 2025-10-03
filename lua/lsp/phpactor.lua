local capabilities = require("blink.cmp").get_lsp_capabilities()
-- Phpactor: refactor & code actions only
vim.lsp.config.phpactor = {
	cmd = { "phpactor", "language-server", "-vvv" },
	filetypes = { "php" },
  root_markers = { ".git", "composer.json", "index.php" },
	capabilities = capabilities,
	on_attach = function(client)
		-- turn off features we prefer Intelephense to handle
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.documentSymbolProvider = false
		client.server_capabilities.referencesProvider = false
		client.server_capabilities.completionProvider = false
		client.server_capabilities.definitionProvider = false
		client.server_capabilities.typeDefinitionProvider = false
		client.server_capabilities.documentFormattingProvider = false
		-- leave codeActionProvider and renameProvider enabled
	end,
	settings = {
		phpactor = {
			language_server_phpstan = { enabled = false },
			language_server_psalm = { enabled = false },
			inlayHints = {
				enable = true,
				parameterHints = true,
				typeHints = true,
			},
		},
	},
}
vim.lsp.enable("phpactor")
