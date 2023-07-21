return	{
		'ThePrimeagen/harpoon',
		lazy = true,
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{"<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Harpoon add file"},
			{"<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon toggle menu"},
			{"<C-h>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Harpoon nav file 1"},
			{"<C-t>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Harpoon nav file 2"},
			{"<C-n>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Harpoon nav file 3"},
			{"<C-s>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon nav file 4"},
		}
	}
