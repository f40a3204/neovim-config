return {
	'NvChad/nvterm',
	lazy = true,
	keys = {
		{ '<A-f>', '<cmd>lua require("nvterm.terminal").toggle("float")<cr>', desc = 'nvterm' },
		{ '<A-h>', '<cmd>lua require("nvterm.terminal").toggle("horizontal")<cr>', desc = 'nvterm' },
		{ '<A-v>', '<cmd>lua require("nvterm.terminal").toggle("vertical")<cr>', desc = 'nvterm' },
	},
	config = function()
		require("nvterm").setup({
		  terminals = {
		    shell = vim.o.shell,
		    list = {},
		    type_opts = {
		      float = {
			relative = 'editor',
			row = 0.3,
			col = 0.25,
			width = 0.5,
			height = 0.4,
			border = "single",
		      },
		      horizontal = { location = "rightbelow", split_ratio = .3, },
		      vertical = { location = "rightbelow", split_ratio = .5 },
		    }
		  },
		  behavior = {
		    autoclose_on_quit = {
		      enabled = true,
		      confirm = false,
		    },
		    close_on_exit = true,
		    auto_insert = true,
		  },
		})
	end
}
