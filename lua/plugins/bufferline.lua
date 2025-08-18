return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local bufferline = require("bufferline")
			--vim.opt.termguicolors = true,
			bufferline.setup({
				options = {
					-- leave a gap where Neo-tree lives
					offsets = {
						{
							filetype = "neo-tree", -- <- correct filetype
							text = "", -- optional label in the gap
							highlight = "Directory",
							text_align = "left",
							separator = true, -- show a thin separator after the gap
						},
					},
					-- optional tweaks
					always_show_bufferline = true,
					show_buffer_close_icons = false,
					show_close_icon = false,
				},
			})
			vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
			vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
			-- <leader>1..9 → jump to tab index 1..9
			for i = 1, 9 do
				vim.keymap.set(
					"n",
					("<leader>%d"):format(i),
					("<cmd>BufferLineGoToBuffer %d<CR>"):format(i),
					{ desc = ("Go to buffer %d"):format(i) }
				)
			end
		end,
	},
}
