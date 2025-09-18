return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				-- Core
				"lua",
				"vim",
				"vimdoc",
				-- Markup
				"markdown",
				"markdown_inline",
				-- Web / Node
				"javascript",
				"typescript",
				"tsx",
				"json",
				"html",
				"css",
        "vue",
				"jsdoc",
				-- PHP
				"php",
				"phpdoc",
				-- Other
				"bash",
				"yaml",
				"dockerfile",
				"query",
				"comment",
			},
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "php", "phtml" },
				callback = function()
					vim.bo.indentexpr = "" -- allow stock php.vim to set indentexpr
					vim.bo.autoindent = true
					vim.bo.smartindent = false
					vim.bo.shiftwidth = 4
					vim.bo.tabstop = 4
					vim.bo.expandtab = true
				end,
			}),
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true, disable = { "php" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
		})
	end,
}
