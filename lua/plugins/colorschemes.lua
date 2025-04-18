return {
	-- Onedark Pro
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		opts = {
			colors = {
				bg = "#19181a",
			},
		},
		init = function()
			-- vim.cmd("colorscheme onedark_vivid") -- apply the collor (set as default)
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		opts = {
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = true,
		},
		init = function()
			vim.cmd("colorscheme gruvbox")
		end,
	},
	-- Monokai Pro
	{
		"loctvl842/monokai-pro.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent_background = true,
			terminal_colors = true,
			devicons = true,
			styles = {
				comment = { italic = true },
				keyword = { italic = true },
				type = { italic = true },
				storageclass = { italic = true },
				structure = { italic = true },
				parameter = { italic = true },
				annotation = { italic = true },
				tag_attribute = { italic = true },
			},
			filter = "spectrum",
			inc_search = "background",
			background_clear = {
				"toggleterm",
				"telescope",
				"renamer",
				"notify",
			},
			plugins = {
				bufferline = {
					underline_selected = false,
					underline_visible = false,
				},
				indent_blankline = {
					context_highlight = "default",
					context_start_underline = false,
				},
			},
			override = function(_) end,
		},
		init = function()
			-- vim.cmd("colorscheme monokai-pro") -- apply the collor (set as default)
		end,
	},
	-- Kanagawa Theme
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			compile = false, -- Enable compiling the colorscheme
			undercurl = true, -- Enable undercurls
			transparent = true, -- Enable transparency
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			dimInactive = false, -- Do not dim inactive windows
			terminalColors = true, -- Define vim.g.terminal_color_{0,17}
			colors = {
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			theme = "wave", -- Default theme
			background = {
				dark = "dragon",
				light = "lotus",
			},
		},
		init = function()
			-- vim.cmd("colorscheme kanagawa") -- apply the collor (set as default)
		end,
	},
	-- Tokyo Night Theme
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		transparent = true,
		opts = {},
	},
}
