return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()

      require('lsp-zero.settings').preset({})
    end
  },


  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
    },
    config = function()
	local lsp = require("lsp-zero")

	lsp.preset("recommended")

	lsp.ensure_installed({
	  'rust_analyzer',
	})

	-- Fix Undefined global 'vim'
	lsp.nvim_workspace()


	local cmp = require('cmp')
	local cmp_select = {behavior = cmp.SelectBehavior.Select}
	local cmp_mappings = lsp.defaults.cmp_mappings({
	--  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	--  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	  ['<cr>'] = cmp.mapping.confirm({ select = true }),
	  ["<C-Space>"] = cmp.mapping.complete(),
	})


	lsp.setup_nvim_cmp({
	  mapping = cmp_mappings
	})

	lsp.set_preferences({
	    suggest_lsp_servers = false,
	    sign_icons = {
		error = '',
		warn = '',
		hint = '',
		info = ''
	    }
	})

	lsp.on_attach(function(client, bufnr)
	  local opts = {buffer = bufnr, remap = false}

	  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	end)

	lsp.setup()

	vim.diagnostic.config({
	    virtual_text = true
	})


    end
  }
}
