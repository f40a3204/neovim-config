return {




	-- 'akinsho/bufferline.nvim',
	{
		'onsails/lspkind.nvim',
		lazy = true
	},




	'nanozuki/tabby.nvim',

	{
	  "smjonas/inc-rename.nvim",
	  lazy = true,
	  cmd = "IncRename",
	  config = function()
	    require("inc_rename").setup()
	  end,
	},



	{
	    	'goolord/alpha-nvim',
	    	event = "VimEnter",
	    	dependencies = { 'nvim-tree/nvim-web-devicons' },
	    	-- opts = { require'alpha.themes.startify'.config }
	},



	{
		'ellisonleao/gruvbox.nvim',
		lazy = false,
		priority = 1000,
		config = function ()
		require("gruvbox").setup({
		    palette_overrides = {
			dark0 = "#161616",
		    },
		    overrides = {
			SignColumn = {bg = "#161616"},
		    }
		})
		vim.cmd([[colorscheme gruvbox]])
		end,
	},



	{
		'preservim/tagbar',
		keys = {
		      { "<leader>tb", "<cmd>TagbarToggle<cr>", desc = "Tagbar" },
		},
		config = function ()
			vim.g.tagbar_compact = 1
		end
	},
	{
		'VonHeikemen/searchbox.nvim',
	  	dependencies = {
			{'MunifTanjim/nui.nvim'}
		},
		lazy = true,
		keys = {
		      { "<leader>se", ":SearchBoxIncSearch<cr>", desc = "search" },
	    	},
	},

	{
		'nvim-treesitter/playground',
		cmd = 'TSPlaygroundToggle'
	},

	{
		'nvim-tree/nvim-web-devicons',
		lazy = true
	},

	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-nvim-lsp',
	'tpope/vim-repeat',


	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end
	},



    	"rcarriga/nvim-notify",



	{
		'rebelot/heirline.nvim',
		lazy = false
	},


	'SmiteshP/nvim-navic',



	{
	  	'gorbit99/codewindow.nvim',

		lazy = true,
		keys = {
		      { "<leader>mm", "<cmd>lua require('codewindow').toggle_minimap()<cr>", desc = "NeoTree" },
	},

	  	config = function()
	    		local codewindow = require('codewindow')
	    		codewindow.setup()
	  	end,
	},

	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{
				'williamboman/mason.nvim',
				build = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{'williamboman/mason-lspconfig.nvim'},

			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
	},

	'lewis6991/gitsigns.nvim',

}
