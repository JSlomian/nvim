return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			notify_on_error = false,
			formatters_by_ft = {
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" }, -- React JSX
				typescriptreact = { "prettierd", "prettier" }, -- React TSX
				vue = { "prettierd", "prettier" }, -- Vue
				svelte = { "prettierd", "prettier" }, -- Svelte
				json = { "prettierd", "prettier" },
				yaml = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				scss = { "prettierd", "prettier" },
				less = { "prettierd", "prettier" },
				-- graphql = { "prettierd", "prettier" },
				-- python = { "black" },
				php = {
					"easy-coding-standard", -- ECS
					-- "pint", -- Laravel Pint
					-- "php-cs-fixer", -- PHP CS Fixer
					-- "phpcbf", -- PHP_CodeSniffer
				},
				blade = { "blade-formatter" }, -- Laravel Blade
				twig = { "twig-cs-fixer" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				cs = { "dotnet-format" },
				lua = { "stylua" },
				go = { "gofmt" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				toml = { "taplo" },
			},
			formatters = {
				prettier = { prefer_local = "node_modules/.bin" },
				["easy-coding-standard"] = {
					command = "vendor/bin/ecs",
					args = { "check", "--fix", "--no-interaction", "--quiet", "$FILENAME" },
					stdin = false,
				},
				-- phpcbf = { prefer_local = "vendor/bin" },
				-- pint = { prefer_local = "vendor/bin" },
				-- ["php-cs-fixer"] = { prefer_local = "vendor/bin" },
			},
		})
	end,
	vim.keymap.set("n", "<leader>cl", function()
		vim.lsp.buf.code_action({
			apply = true,
			context = { only = { "source.fixAll.eslint" } },
		})
	end, { desc = "ESLint: Fix all (LSP)" }),
	vim.keymap.set("n", "<leader>cf", function()
		require("conform").format({ async = true, lsp_fallback = true })
	end, { desc = "Format file" }),
	vim.keymap.set("n", "<M-f>", function()
		require("conform").format({ async = true, lsp_fallback = true })
	end, { desc = "Format file" }),
}
