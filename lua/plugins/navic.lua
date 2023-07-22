return {
	'SmiteshP/nvim-navic',
	lazy = true,
	event = "BufEnter",
	config = function ()
		local navic = require("nvim-navic")

		require("lspconfig").clangd.setup {
			on_attach = function(client, bufnr)
				navic.attach(client, bufnr)
			end
		}

		require("lspconfig").lua_ls.setup {
			on_attach = function(client, bufnr)
				navic.attach(client, bufnr)
			end
		}

		require("lspconfig").hls.setup {
			on_attach = function(client, bufnr)
				navic.attach(client, bufnr)
			end
		}
		require("lspconfig").rust_analyzer.setup {
			on_attach = function(client, bufnr)
				navic.attach(client, bufnr)
			end
		}

		require("lspconfig").pyright.setup {
			on_attach = function(client, bufnr)
				navic.attach(client, bufnr)
			end
		}

		require("lspconfig").zls.setup {
			on_attach = function(client, bufnr)
				navic.attach(client, bufnr)
			end
		}

		require("lspconfig").elixirls.setup {
			on_attach = function(client, bufnr)
				navic.attach(client, bufnr)
			end
		}

		require("lspconfig").clojure_lsp.setup {
			on_attach = function(client, bufnr)
				navic.attach(client, bufnr)
			end
		}
	end
}
