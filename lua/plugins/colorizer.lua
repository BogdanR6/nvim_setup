return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"*", -- Enable for all filetypes
		})
	end,
	-- if it does not work to start it manually run: :ColorizerAttachToBuffer
}
