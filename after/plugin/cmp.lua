local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require('lspkind')


require'cmp'.setup {
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
  capabilities = capabilities,
}

-- If you want insert `(` after select function or method item
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
})


