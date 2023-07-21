return	{
	'prichrd/netrw.nvim',
	lazy = true,
	event = "BufEnter",
	config = function()
	require'netrw'.setup{
	  icons = {
	    symlink = '',
	    directory = '',
	    file = '',
	  },
	  use_devicons = true,
	  mappings = {},
	}
	end
}
