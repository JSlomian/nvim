local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config.eslint = {
	capabilities = capabilities,
	settings = {
		workingDirectory = { mode = "location" },
		codeAction = { disableRuleComment = { enable = true }, showDocumentation = { enable = true } },
		format = true,
	},
}
vim.lsp.enable("eslint")
