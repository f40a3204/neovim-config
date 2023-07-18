return {
	{
		'prichrd/netrw.nvim',
		lazy = false,
	},

	'akinsho/bufferline.nvim',
	{
		'onsails/lspkind.nvim',
		lazy = true
	},

	{
		"kdheepak/lazygit.nvim",
		dependencies = {
		    "nvim-lua/plenary.nvim",
		},
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
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		lazy = false
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
		'nvim-treesitter/playground',
		cmd = 'TSPlaygroundToggle'
	},

	{
		'ThePrimeagen/harpoon',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	'mbbill/undotree',
	{
		'tpope/vim-fugitive',
		lazy = true,
		cmd = "Git"
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
		'ggandor/leap.nvim',
		lazy = false,
	},
	{
		'sbdchd/neoformat',
		lazy = true,
		cmd = "Neoformat"
	},
	"lukas-reineke/indent-blankline.nvim",

	{
		'ThePrimeagen/vim-be-good',
		lazy = true,
		cmd = "VimBeGood"
	},

	'SirVer/ultisnips',

	'quangnguyen30192/cmp-nvim-ultisnips',

	{
		"startup-nvim/startup.nvim",
		dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
		config = function()
			require"startup".setup()
		end
	},


	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup {}
		end
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
	    	branch = "v3.x",
	    	cmd = "Neotree",
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
	},

	{
		'rebelot/heirline.nvim',
		lazy = false
	},

	'NvChad/nvterm',

	'SmiteshP/nvim-navic',

	{
		'echasnovski/mini.nvim',
		lazy = true,
		version = '*',
	    	keys = {
		      { "<leader>mm", "<cmd>lua MiniMap.toggle()<cr>", desc = "MiniMap" },
	    	},
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
