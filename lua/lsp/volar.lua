local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config.vue_ls = {
	capabilities = capabilities,
	filetypes = { "vue" },
	init_options = {
		typescript = {
			-- Prefer project TS; fall back to Mason if you want
			tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
			-- tsdk = vim.fn.stdpath('data') .. '/mason/packages/typescript-language-server/node_modules/typescript/lib',
		},
	},
	-- on_attach = function(client)
	-- 	client.server_capabilities.semanticTokensProvider =
	-- 		client.server_capabilities.semanticTokensProvider
	-- end,
}
vim.lsp.enable("vue_ls")
