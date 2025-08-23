return {
	{
		"Bekaboo/deadcolumn.nvim",
		config = function()
			-- Enable editorconfig (default in 0.9+ but let’s be explicit)
			vim.g.editorconfig = true

			-- Autocmd to set colorcolumn based on textwidth (from .editorconfig)
			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function()
					if vim.bo.textwidth > 0 then
						vim.wo.colorcolumn = "+0" -- match textwidth
					else
						vim.wo.colorcolumn = "" -- no limit if none specified
					end
				end,
			})
		require("deadcolumn").setup({
			scope = "buffer",
		})
		end,
	},
}
