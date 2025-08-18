return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[                                                                       ]],
			[[                                                                     ]],
			[[       ████ ██████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      █████████ ███████████████████ ███   ███████████   ]],
			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			[[                                                                       ]],
		}
		-- set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", " New File", "<cmd>ene<CR>"),
			dashboard.button("f", " Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("C-n", " Toggle File Explorer", "Neotree filesystem toggle left<CR>"),
			dashboard.button("r", " Restore Session", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", " quit", "<cmd>qa<CR>"),
		}
		alpha.setup(dashboard.opts)
	end,
}
