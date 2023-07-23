return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		build = ":MasonUpdate",
		cmd = {
			"MasonUpdate",
			"MasonInstall",
			"Mason",
			"MasonLog",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonUpdate",
			"MasonDebug"
		},
		config = function()
			require('mason').setup()
		end
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		config = function()
			local lspconfig = require('lspconfig')
			require('mason-lspconfig').setup({
				ensure_installed = {
					'rust_analyzer',
				}
			})
			require('mason-lspconfig').setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = lsp_capabilities,
					})
				end,
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufEnter",
		lazy = true,
		keys = {
			{ "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
			{ "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
			{ "<leader>xf", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
			{ "<leader>f",  "<cmd>lua vim.lsp.buf.format()<CR>" },
			{ "<leader>K",  "<cmd>lua vim.lsp.buf.hover()<CR>" },
			{ "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
			{ "<C-k>",      "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
			{ "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>" },
			{ "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>" },
			{ "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>" },
			{ "<leader>D",  "<cmd>lua vim.lsp.buf.type_definition()<CR>" },
			{ "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>" },
			{ "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
		},
		config = function()
			local lspconfig = require('lspconfig')
			require('mason-lspconfig').setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = lsp_capabilities,
					})
				end,
			})
		end
	},
	{
		'ms-jpq/coq_nvim',
		branch = 'coq',
		event = "InsertEnter",
		lazy = true,
		dependencies = {
			{
				'ms-jpq/coq.artifacts',
				branch = 'artifacts'
			},
			{
				'ms-jpq/coq.thirdparty',
				branch = '3p'
			},
		},
		config = function()
			vim.g.coq_settings = {
				auto_start = 'shut-up',
				clients = {
					lsp = {
						enabled = true,
					},
					paths = {
						path_seps = {
							"/"
						}
					},
					buffers = {
						match_syms = true
					},
					tree_sitter = {
						enabled = true,
						weight_adjust = 1.0
					},
				},
			}

			local coq = require("coq")

			coq.Now()
		end
	},


}
