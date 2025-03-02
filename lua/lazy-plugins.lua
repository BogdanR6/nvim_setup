require("lazy").setup({
  spec = {
    -- My plugins
    { import = "plugins" },
  },

  opts = {
    colorscheme = "kanagawa",
  },

  defaults = {
    lazy = true,
    version = false, -- always use the latest version
  },

  checker = { enabled = true, notify = false }, -- plugin update checker

}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
