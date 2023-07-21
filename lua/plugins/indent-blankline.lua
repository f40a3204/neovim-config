return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufEnter",
	lazy = true,
	config = function ()
		require("indent_blankline").setup {}
	end
}
