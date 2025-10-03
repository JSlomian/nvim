return {
	dir = vim.fn.stdpath("config") .. "/lua/plugins/lsp",
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
					vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
					vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
					vim.keymap.set("i", "<C-Space>", function()
						vim.lsp.completion.get()
					end)
				end
			end,
		})

		-- Diagnostics
		vim.diagnostic.config({
			-- Use the default configuration
			-- virtual_lines = true

			-- Alternatively, customize specific options
			virtual_lines = {
				-- Only show virtual line diagnostics for the current cursor line
				current_line = true,
			},
		})
		--  vim.diagnostic.config({
		-- 	virtual_text = {
		-- 		severity = {
		-- 			min = vim.diagnostic.severity.HINT, -- show all
		-- 		},
		-- 		spacing = 2,
		-- 		format = function(diagnostic)
		-- 			local icons = {
		-- 				[vim.diagnostic.severity.ERROR] = "󰅚",
		-- 				[vim.diagnostic.severity.WARN] = "",
		-- 				[vim.diagnostic.severity.INFO] = "",
		-- 				[vim.diagnostic.severity.HINT] = "󰌶",
		-- 			}
		-- 			return string.format("%s %s", icons[diagnostic.severity], diagnostic.message)
		-- 		end,
		-- 	},
		-- 	signs = false,
		-- })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Documentation" })
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Help" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })
		-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
		vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, { desc = "Rename" })
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" }) -- float
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, { silent = true })
		-- or:
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true })

		-- navigate
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
	end,
}
