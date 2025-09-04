return {
	{
		"b0o/schemastore.nvim",
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "jsonls", "eslint" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.diagnostic.config({
				virtual_text = {
					severity = {
						min = vim.diagnostic.severity.HINT, -- show all
					},
					spacing = 2,
					format = function(diagnostic)
						local icons = {
							[vim.diagnostic.severity.ERROR] = "󰅚",
							[vim.diagnostic.severity.WARN] = "",
							[vim.diagnostic.severity.INFO] = "",
							[vim.diagnostic.severity.HINT] = "󰌶",
						}
						return string.format("%s %s", icons[diagnostic.severity], diagnostic.message)
					end,
				},
				signs = false,
			})
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			local vue_plugin_path = util.path.join(
				vim.fn.stdpath("data"),
				"mason",
				"packages",
				"vue-language-server",
				"node_modules",
				"@vue",
				"language-server"
			)
			lspconfig.vtsls.setup({
				capabilities = capabilities,
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
				},
				on_attach = function(client, bufnr)
					if vim.bo[bufnr].filetype == "vue" then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
				-- on_attach = function(client, bufnr)
				-- 	if vim.bo[bufnr].filetype == "vue" then
				-- 		client.server_capabilities.documentFormattingProvider = false
				-- 		client.server_capabilities.semanticTokensProvider = nil
				-- 		client.server_capabilities.hoverProvider = false
				-- 		client.server_capabilities.signatureHelpProvider = nil
				-- 		client.server_capabilities.completionProvider = nil
				-- 		-- (Volar will provide these)
				-- 	end
				-- end,
				-- init_options = {
				-- 	plugins = {
				-- 		{
				-- 			name = "@vue/typescript-plugin",
				-- 			-- use the copy that Mason installed:
				-- 			location = util.path.join(
				-- 				vim.fn.stdpath("data"),
				-- 				"mason",
				-- 				"packages",
				-- 				"vue-language-server",
				-- 				"node_modules",
				-- 				"@vue",
				-- 				"language-server"
				-- 			),
				-- 			languages = { "vue" },
				-- 		},
				-- 	},
				-- },
				settings = {
					vtsls = {
						tsserver = {
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
			})

			-- Vue language server (Volar)
			lspconfig.vue_ls.setup({
				capabilities = capabilities,
				filetypes = { "vue" },
				init_options = {
					typescript = {
						-- Prefer project TS; fall back to Mason if you want
						tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
						-- tsdk = vim.fn.stdpath('data') .. '/mason/packages/typescript-language-server/node_modules/typescript/lib',
					},
				},
				on_attach = function(client)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			lspconfig.eslint.setup({
				capabilities = capabilities,
				settings = {
					workingDirectory = { mode = "location" },
					codeAction = { disableRuleComment = { enable = true }, showDocumentation = { enable = true } },
					format = true,
				},
			})
			-- Phpactor: refactor & code actions only
			lspconfig.phpactor.setup({
				cmd = { "phpactor", "language-server", "-vvv" },
				filetypes = { "php" },
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
			})

			-- Intelephense: completions, hover, diagnostics, symbols
			lspconfig.intelephense.setup({
				cmd = { "intelephense", "--stdio" },
				filetypes = { "php" },
				capabilities = capabilities,
				on_attach = function(client)
					-- disable workspace symbols if you want Phpactor to handle them
					client.server_capabilities.workspaceSymbolProvider = false
				end,
				settings = {
					intelephense = {
						completion = {
							callSnippet = "Replace",
							insertFullyQualifiedNames = false, -- show FQN in menu, insert short name
							fullyQualifyGlobalConstantsAndFunctions = true,
						},
					},
				},
			})
			-- vim.keymap.set("n", "gd", function()
			--   vim.lsp.buf.definition()
			--   vim.defer_fn(function()
			--     -- put cursor line at the top of the window
			--     vim.cmd("normal! zt")
			--   end, 50) -- delay lets LSP finish jumping
			-- end, { buffer = true })

			-- vim.keymap.set("n", "gd", function()
			--   vim.lsp.buf.definition()
			--   vim.defer_fn(function()
			--     local ts_utils = require("nvim-treesitter.ts_utils")
			--     local node = ts_utils.get_node_at_cursor()
			--     while node do
			--       if node:type():match("function") or node:type():match("method") then
			--         local start_row = node:range()
			--         vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
			--         vim.cmd("normal! zt")
			--         break
			--       end
			--       node = node:parent()
			--     end
			--   end, 80)
			-- end, { buffer = true, desc = "Definition" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Documentation" })
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Help" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })
			vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, { desc = "Rename" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" }) -- float
			vim.keymap.set("n", "gl", vim.diagnostic.open_float, { silent = true })
			-- or:
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true })

			-- navigate
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
		end,
	},
}
