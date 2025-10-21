return {
	"nvim-java/nvim-java",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap", -- Make sure this loads first
		"rcarriga/nvim-dap-ui",
		"nvim-java/lua-async-await",
		"nvim-java/nvim-java-core",
		"nvim-java/nvim-java-test",
		"nvim-java/nvim-java-dap",
		"nvim-java/nvim-java-refactor",
	},
	config = function()
		-- Load nvim-dap first
		local ok, dap = pcall(require, "dap")
		if not ok then
			vim.notify("nvim-dap not found! Please install it first.", vim.log.levels.ERROR)
			return
		end

		require("java").setup({
			-- optional settings
		})
	end,
}
