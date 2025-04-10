-- [[ Setting options ]]

local options = {
	termguicolors = true, -- Enable terminal colors
	number = true, -- Enable line numbers
	relativenumber = true, -- Enable relative line numbers
	mouse = "a", -- Enable mouse mode, can be useful for resizing splits for example!
	showmode = false, -- Don't show the mode, since it's already in the status line
	breakindent = true, -- Enable break indent
	undofile = true, -- Save undo history

	wrap = false,

	-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
	ignorecase = true,
	smartcase = true,

	-- Keep signcolumn on by default
	signcolumn = "yes",

	-- Decrease update time
	updatetime = 250,

	-- Decrease mapped sequence wait time
	-- Displays which-key popup sooner
	timeoutlen = 300,

	-- Configure how new splits should be opened
	splitright = true,
	splitbelow = true,

	-- Sets how neovim will display certain whitespace characters in the editor.
	--  See `:help 'list'`
	--  and `:help 'listchars'`
	list = true,
	listchars = { tab = "  ", trail = " ", nbsp = "␣" },
	tabstop = 2,
	shiftwidth = 2,
	softtabstop = 2,
	expandtab = true,

	-- Preview substitutions live, as you type!
	inccommand = "split",

	-- Show which line your cursor is on
	cursorline = true,

	-- Minimal number of screen lines to keep above and below the cursor.
	scrolloff = 10,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd([[
  autocmd FileType cpp,c,h,hpp setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
]])

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- vim: ts=2 sts=2 sw=2 et
