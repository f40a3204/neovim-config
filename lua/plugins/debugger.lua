return {
	{
		'mfussenegger/nvim-dap',
		lazy = true,
		keys = {
			{ "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
			{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",          desc = "Continue" },
			{ "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",         desc = "Step Into" },
			{ "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",         desc = "Step Over" },
			{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>",       desc = "Toggle Repl" },
			{ "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>",         desc = "Terminate" },
		},
		config = function()
		end
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		keys = {
			{ "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle Breakpoint" },
		}
	}

}
