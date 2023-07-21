return {
    	"hrsh7th/nvim-cmp",
	lazy = true,
    	event = "InsertEnter",
    	config = function ()
		local cmp_action = require('lsp-zero').cmp_action()
		local lspkind = require('lspkind')


		require'cmp'.setup {
		sources = {
				{ name = 'path' },
				{ name = 'nvim_lsp' },
				{ name = 'buffer' },
			}
		}

		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		require'lspconfig'.clangd.setup {
			capabilities = capabilities,
		}

		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local cmp = require('cmp')
		cmp.event:on(
			'confirm_done',
			cmp_autopairs.on_confirm_done()
		)

		cmp.setup({
			mapping = {
				['<Tab>'] = cmp_action.tab_complete(),
				['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
			},
			view = {
				 entries = 'custom'
			},
			 formatting = {
				format = lspkind.cmp_format(),
		       },
			window = {
				documentation = cmp.config.window.bordered(),
				completion = cmp.config.window.bordered({
				winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None'
				}),
			},
		})
        end
}
