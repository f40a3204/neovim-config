return	{
		"nvim-neo-tree/neo-tree.nvim",
	    	branch = "v3.x",
	    	cmd = "Neotree",
		lazy = true,
	    	keys = {
		      { "<leader>pn", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
	    	},
	    	config = function()
			require("neo-tree").setup({
				source_selector = {
				winbar = true,
				statusline = true
			}
			})
		end,
	    	dependencies = {
	      		"MunifTanjim/nui.nvim",
	    	}
	}

