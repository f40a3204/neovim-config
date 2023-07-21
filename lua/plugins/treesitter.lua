return	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		lazy = true,
		event = "BufEnter",
		config = function()
			require'nvim-treesitter.configs'.setup {
			  	ensure_installed = { "vim", "lua", "rust" },

			  	sync_install = false,
			  	auto_install = true,
			  	highlight = {
			    		enable = true,
			    		additional_vim_regex_highlighting = false,
			 	},
			}
		end
	}
