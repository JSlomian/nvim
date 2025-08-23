return {
	"typed-rocks/ts-worksheet-neovim",
	opts = {
		severity = vim.diagnostic.severity.WARN,
	},
	config = function(_, opts)
		local tsw = require("tsw")
		tsw.setup(opts)
		vim.keymap.set("n", "<leader>crn", "<cmd>Tsw rt=node<CR>", { desc = "Run typescript worksheeth" })
	end,
}
