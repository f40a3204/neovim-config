return	{
		'luukvbaal/nnn.nvim',
		config = function() require('nnn').setup() end,
		lazy = true,
		keys = {
			{ '<leader>nn', '<cmd>NnnExplorer<cr>', desc = 'nnn' },
		}
	}

