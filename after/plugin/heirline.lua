local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
vim.cmd('highlight StatusLine guifg=#3c3836 guibg=#3c3836')
vim.o.laststatus = 3

vim.opt.shortmess:append("F")

local ViMode = {
	-- get vim current mode, this information will be required by the provider
	-- and the highlight functions, so we compute it only once per component
	-- evaluation and store it as a component attribute
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
	end,
	-- Now we define some dictionaries to map the output of mode() to the
	-- corresponding string and color. We can put these into `static` to compute
	-- them at initialisation time.
	static = {
		mode_names = { -- change the strings if you like it vvvvverbose!
			n = "Normal",
			no = "N?",
			nov = "N?",
			noV = "N?",
			["no\22"] = "N?",
			niI = "Ni",
			niR = "Nr",
			niV = "Nv",
			nt = "Visual Select",
			v = "Visual",
			vs = "Visual Selection",
			V = "Visual Selection",
			Vs = "Vs",
			["\22"] = "^V",
			["\22s"] = "^V",
			s = "S",
			S = "S_",
			["\19"] = "^S",
			i = "Insert",
			ic = "Autocomplete",
			ix = "Ix",
			R = "R",
			Rc = "Rc",
			Rx = "Rx",
			Rv = "Rv",
			Rvc = "Rv",
			Rvx = "Rv",
			T = "Terminal",
			c = "Command",
			cv = "Ex",
			r = "...",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "Terminal",
		},
		mode_colors = {
			n = "red",
			i = "green",
			v = "cyan",
			V = "cyan",
			["\22"] = "cyan",
			c = "orange",
			s = "purple",
			S = "purple",
			["\19"] = "purple",
			R = "orange",
			r = "orange",
			["!"] = "red",
			t = "red",
		}
	},
	provider = function(self)
		return "%2(" .. self.mode_names[self.mode] .. "%) "
	end,
	hl = function(self)
		return { fg = "#282828", bg = "#a89985", bold = true, }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}


local FileNameBlock = {
	-- let's first set up some attributes needed by this component and it's children
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	hl = { bg = "#282828", fg = "#a4917b" }
}
-- We can now define some children separately and add them later

local FileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension,
			{ default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = "#a4917b", bg = "#504945" }
	end
}

local FileName = {
	provider = function(self)
		-- first, trim the pattern relative to the current directory. For other
		-- options, see :h filename-modifers
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then return "[No Name]" end
		-- now, if the filename would occupy more than 1/4th of the available
		-- space, we trim the file path to its initials
		-- See Flexible Components section below for dynamic truncation
		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return filename
	end,
	hl = { bg = "#504945", fg = "#a4917b" },
}

local FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = "[+]",
		hl = { fg = "#a4917b", bg = "#504945" },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = " ",
		hl = { fg = "#a4917b", bg = "#504945" },
	},
}
-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

local FileNameModifer = {
	hl = function()
		if vim.bo.modified then
			-- use `force` because we need to override the child's hl foreground
			return { bg = "#3c3836", fg = "#a4917b", bold = true, force = true }
		end
	end,
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
	FileIcon,
	utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
	FileFlags,
	{ provider = '%< ',
	hl = { fg = "#a4917b", bg = "#504945" }
}                  -- this means that the statusline is cut here when there's not enough space
)

local Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = "%7(%l/%3L%):%2c %P",
	hl = { fg = "#3a2828", bg = "#a89985" },
}

local ScrollBar = {
	static = {
		sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
		-- Another variant, because the more choice the better.
		-- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
	},
	provider = function(self)
		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)
		local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
		return string.rep(self.sbar[i], 2)
	end,
	hl = { fg = "#a89985", bg = "#3a2828" },
}


local LSPActive = {
	condition = conditions.lsp_attached,
	update    = { 'LspAttach', 'LspDetach' },

	-- You can keep it simple,
	-- provider = " [LSP]",

	-- Or complicate things a bit and get the servers names
	provider  = function()
		local names = {}
		for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return "  [" .. table.concat(names, " ") .. "]"
	end,
	hl        = { bg = "#504945", fg = "#a4917b", bold = true },
}

local Navic = {
	condition = function() return require("nvim-navic").is_available() end,
	static = {
		-- create a type highlight map
		type_hl = {
			File = "Directory",
			Module = "@include",
			Namespace = "@namespace",
			Package = "@include",
			Class = "@structure",
			Method = "@method",
			Property = "@property",
			Field = "@field",
			Constructor = "@constructor",
			Enum = "@field",
			Interface = "@type",
			Function = "@function",
			Variable = "@variable",
			Constant = "@constant",
			String = "@string",
			Number = "@number",
			Boolean = "@boolean",
			Array = "@field",
			Object = "@type",
			Key = "@keyword",
			Null = "@comment",
			EnumMember = "@field",
			Struct = "@structure",
			Event = "@keyword",
			Operator = "@operator",
			TypeParameter = "@type",
		},
		-- bit operation dark magic, see below...
		enc = function(line, col, winnr)
			return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
		end,
		-- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
		dec = function(c)
			local line = bit.rshift(c, 16)
			local col = bit.band(bit.rshift(c, 6), 1023)
			local winnr = bit.band(c, 63)
			return line, col, winnr
		end
	},
	init = function(self)
		local data = require("nvim-navic").get_data() or {}
		local children = {}
		-- create a child for each level
		for i, d in ipairs(data) do
			-- encode line and column numbers into a single integer
			local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
			local child = {
				{
					provider = d.icon,
					hl = self.type_hl[d.type],
				},
				{
					-- escape `%`s (elixir) and buggy default separators
					provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ''),
					-- highlight icon only or location name as well
					-- hl = self.type_hl[d.type],

					on_click = {
						-- pass the encoded position through minwid
						minwid = pos,
						callback = function(_, minwid)
							-- decode
							local line, col, winnr = self.dec(minwid)
							vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
						end,
						name = "heirline_navic",
					},
				},
			}
			-- add a separator only if needed
			if #data > 1 and i < #data then
				table.insert(child, {
					provider = " > ",
					hl = { fg = 'green' },
				})
			end
			table.insert(children, child)
		end
		-- instantiate the new child, overwriting the previous one
		self.child = self:new(children, 1)
	end,
	-- evaluate the children containing navic components
	provider = function(self)
		return self.child:eval()
	end,
	hl = { bg = "#3c3836", fg = "#a4917b" },
	update = 'CursorMoved'
}

local Git = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or
		self.status_dict.changed ~= 0
	end,

	hl = { fg = "#85bc68", bg = "#504945" },


	{ -- git branch name
		provider = function(self)
			return " " .. self.status_dict.head
		end,
		hl = { bold = true }
	},
	-- You could handle delimiters, icons and counts similar to Diagnostics
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = "("
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and ("+" .. count)
		end,
		hl = { fg = "git_add" },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and ("-" .. count)
		end,
		hl = { fg = "git_del" },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and ("~" .. count)
		end,
		hl = { fg = "git_change" },
	},
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = ")",
	},
}

local Diagnostics = {

	condition = conditions.has_diagnostics,

	static = {
		error_icon = " ",
		warn_icon = " ",
		info_icon = " ",
		hint_icon = " ",
	},

	hl = { bg = "#3c3836", fg = "#a4917b" },

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	update = { "DiagnosticChanged", "BufEnter" },

	{
		provider = "[",
	},
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = "#a4917b" },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = "#a4917b" },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = "#a4917b" },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = { fg = "#a4917b" },
	},
	{
		provider = "]",
	},
}

local WorkDir = {
	provider = function()
		local icon = (vim.fn.haslocaldir(0) == 1 and "󰜛" or "󰑔") .. " " .. " "
		local cwd = vim.fn.getcwd(0)
		cwd = vim.fn.fnamemodify(cwd, ":~")
		if not conditions.width_percent_below(#cwd, 0.25) then
			cwd = vim.fn.pathshorten(cwd)
		end
		local trail = cwd:sub(-1) == '/' and '' or "/"
		return icon .. cwd .. trail
	end,
	hl = { bg = "#a89985", fg = "#3a2828", bold = true },
}


local FileType = {
	provider = function()
		return string.upper(vim.bo.filetype) .. " "
	end,
	hl = { fg = "#a4917b", bg = "#504945", bold = true },
}



local Align = { provider = "%=" }
local Space = { provider = " " }
local Line = {
	provider = "",
	hl = { fg = "#a89985", bg = "#504945" },
}
local GrayLine = {
	provider = "",
	hl = { fg = "#504945", bg = "#a89985" },
}
local LightGrayLine = {
	provider = "",
	hl = { fg = "#3c3836", bg = "#504945" },
}
local ReverseGrayLine = {
	provider = "",
	hl = { fg = "#504945" , bg = "#3c3836" },
}
local Blocks = {
	provider = "█",
	hl = { bg = "#3c3836", fg = "#a89985" },
}
local GrayBlocks = {
	provider = "█",
	hl = { bg = "#a89985", fg = "#a89985" },
}
local LightGrayBlocks = {
	provider = "█",
	hl = { bg = "#a89985", fg = "#504945" },
}


local StatusLine = {
	Blocks, ViMode, Line, LightGrayBlocks, FileNameBlock, ReverseGrayLine, Git, Space, Diagnostics, Align,
	Navic, Space, Align,
	LightGrayLine, LSPActive, LightGrayBlocks, FileType, GrayLine, WorkDir, GrayBlocks, Ruler, GrayBlocks -- , Blocks
}


require("heirline").setup({
	statusline = StatusLine,
})
