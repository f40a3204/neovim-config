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
			{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
			{ "xf", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
		},
		config = function()
			local lspconfig = require('lspconfig')
		--	vim.api.nvim_create_autocmd('LspAttach', {
		--	  desc = 'LSP actions',
		--	  callback = function(event)
		--		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		--		vim.keymap.set("n", "fx", function() vim.lsp.buf.code_action() end, opts)
		--	  end
		--	})
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
