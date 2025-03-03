return {
	-- Kanagawa Theme
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			compile = false,  -- Enable compiling the colorscheme
			undercurl = true, -- Enable undercurls
			transparent = true, -- Enable transparency
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			dimInactive = false,   -- Do not dim inactive windows
			terminalColors = true, -- Define vim.g.terminal_color_{0,17}
			colors = {
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors) return {} end,
			theme = "wave", -- Default theme
			background = {
				dark = "dragon",
				light = "lotus"
			},
		},
		init = function()
			vim.cmd("colorscheme kanagawa") -- apply the collor (set as default)
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
