return	{
	  	'stevearc/aerial.nvim',
	  	opts = {},
	  	dependencies = {
	     		"nvim-treesitter/nvim-treesitter",
	     		"nvim-tree/nvim-web-devicons"
	  	},
		keys = {
			{ "<C-a>", "<cmd>AerialToggle!<cr>", desc = "Aerial" },
			{ "{", "<cmd>AerialPrev<cr>", desc = "Aerial" },
			{ "}", "<cmd>AerialNext<cr>", desc = "Aerial" },
		},
		config = function ()
			require('aerial').setup()
		end
	}
