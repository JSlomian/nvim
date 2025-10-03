local capabilities = require("blink.cmp").get_lsp_capabilities()
local vue_plugin_path = vim.fs.joinpath(
	vim.fn.stdpath("data"),
	"mason",
	"packages",
	"vue-language-server",
	"node_modules",
	"@vue",
	"language-server"
)
vim.lsp.config.vtsls = {
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
	},
	-- on_attach = function(client, bufnr)
	-- 	-- Let Volar own semantic tokens in .vue to avoid races & extra work
	-- 	if vim.bo[bufnr].filetype == "vue" then
	-- 		pcall(vim.lsp.semantic_tokens.stop, bufnr, client.id)
	-- 		vim.b[bufnr].vtsls_semantic_tokens_disabled = true
	-- 	end
	-- end,
	-- root_dir = util.root_pattern("tsconfig.json", "package.json", ".git"),
  root_markers = {
    "tsconfig.json",
    "package.json",
    ".git"
  },
	settings = {
		vtsls = {
			tsserver = {
				maxTsServerMemory = 4096,
				useSyntaxServer = "auto",
				watchOptions = {
					watchFile = "useFsEvents",
					watchDirectory = "useFsEvents",
					fallbackPolling = "dynamicPriority",
					synchronousWatchDirectory = false,
				},
				typescript = {
					preferences = {
						includePackageJsonAutoImports = "off",
					},
					suggest = {
						completeFunctionCalls = true,
						autoImports = true,
					},
				},
				javascript = {
					preferences = {
						includePackageJsonAutoImports = "off",
					},
				},
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_plugin_path,
						languages = { "vue" },
						configNamespace = "typescript",
					},
				},
			},
		},
	},
}
vim.lsp.enable("vtsls")
