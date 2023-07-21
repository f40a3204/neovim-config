return	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		lazy = true,
		config = function()
			require("nvim-autopairs").setup {}
			local M = {}

			function M.setup()
			  local npairs = require "nvim-autopairs"
			  npairs.setup {
			    check_ts = true,
			  }
			  npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
			end

			return M
		end
	}
