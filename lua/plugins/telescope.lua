return	{
	    	'nvim-telescope/telescope.nvim', branch = '0.1.x',
		cmd = "Telescope",
		lazy = true,
	      	dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Find text" },
			{ "<leader>ps", "<cmd>Telescope live_grep<cr>", desc = "Find buffers"},
		}
    	}
