
function ColorMyPencils(color)
	-- color = color or "gruvbox"
	-- vim.cmd.colorscheme(color)
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

require("gruvbox").setup({
    palette_overrides = {
	dark0 = "#161616",
    },
    overrides = {
	 SignColumn = {bg = "#161616"},
    }
})

vim.cmd([[highlight netrwDir guifg=#920D09]])
-- ColorMyPencils()
