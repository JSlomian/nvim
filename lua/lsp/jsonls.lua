local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config.jsonls = {
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
}
vim.lsp.enable("jsonls")
