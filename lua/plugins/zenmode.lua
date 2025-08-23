return {
	{
		"folke/twilight.nvim",
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				window = {
					backdrop = 0.95,
					width = 0.6,
					options = {
						number = true,
						relativenumber = true,
						signcolumn = "no",
					},
				},
				plugins = {
					options = { laststatus = 0 },
				},
			})

			-- keymap
			vim.keymap.set("n", "<leader>zk", "<cmd>ZenMode<CR>", { desc = "Enable ZenMode" })
		end,
	},
}
