--[[
    Lua guide
    - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html
]]

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require("options")

-- [[ Basic Keymaps ]]
require("keymaps")
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- [[ Install `lazy.nvim` plugin manager ]]
require("lazy-bootstrap")

-- [[ Configure and install plugins ]]
require("lazy-plugins")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
