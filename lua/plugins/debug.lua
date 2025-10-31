-- DAP (Debug Adapter Protocol) Configuration
--
-- HOW TO USE THE DEBUGGER IN NEOVIM:
--
-- 1. SET BREAKPOINTS:
--    - Place cursor on the line where you want to pause
--    - Press <leader>b (usually Space + b)
--    - A breakpoint indicator will appear in the sign column
--    - Press <leader>b again to remove the breakpoint
--
-- 2. START DEBUGGING:
--    - Press <F5> to start debugging
--    - For Go: It will automatically start debugging the current package
--    - The debugger will pause at your first breakpoint
--
-- 3. CONTROL EXECUTION:
--    - <F5>  - Continue (run until next breakpoint)
--    - <F1>  - Step Into (enter function calls)
--    - <F2>  - Step Over (execute current line, don't enter functions)
--    - <F3>  - Step Out (exit current function)
--
-- 4. VIEW DEBUG INFO:
--    - Press <F7> to toggle the debug UI
--    - The UI shows:
--      * Variables and their values
--      * Call stack
--      * Breakpoints list
--      * Watch expressions
--      * Console output
--
-- 5. CONDITIONAL BREAKPOINTS:
--    - Press <leader>B (capital B)
--    - Enter a condition (e.g., "x > 10")
--    - Debugger will only pause when condition is true
--
-- 6. STOP DEBUGGING:
--    - Press the terminate button in the debug UI
--    - Or close Neovim
--
-- EXAMPLE WORKFLOW (Go):
--   1. Open a Go file
--   2. Press <leader>b on a line to set a breakpoint
--   3. Press <F5> to start debugging
--   4. Press <F7> to see variables and stack
--   5. Use <F2> to step through code
--   6. Hover over variables to see their values

return {
	"mfussenegger/nvim-dap",

	enabled = true,

	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		"theHamsta/nvim-dap-virtual-text",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		"leoluz/nvim-dap-go",
	},
	keys = {
		-- Basic debugging keymaps, feel free to change to your liking!
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/Continue",
		},
		{
			"<F1>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<F2>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step Over",
		},
		{
			"<F3>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Out",
		},
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>B",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Debug: Set Breakpoint",
		},
		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		{
			"<F7>",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: See last session result.",
		},
		{
			"<leader>da",
			function()
				local dap = require("dap")
				local args_string = vim.fn.input("Launch args (space-separated): ")
				local args = vim.split(args_string, " ", { trimempty = true })

				for _, config in ipairs(dap.configurations.go) do
					if config.request == "launch" then
						config.args = args
					end
				end

				print("Set launch args: " .. vim.inspect(args))
			end,
			desc = "Debug: Set launch arguments",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Helper for setting launch arguments
		local dap_common = {}

		function dap_common.set_launch_args(lang, args)
			if dap.configurations[lang] == nil then
				error(("Configuration for %s is not defined!"):format(lang))
			end

			if type(args) ~= "table" and args ~= nil then
				error(("Invalid arguments %s of type %s specified! Must be a table or nil"):format(args, type(args)))
			end

			for _, config in ipairs(dap.configurations[lang]) do
				if config.request == "launch" then
					config.args = args
				end
			end
		end

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"delve", -- Go debugger
			},
		})

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- Change breakpoint icons
		vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
		vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
		local breakpoint_icons = vim.g.have_nerd_font
				and { Breakpoint = "", BreakpointCondition = "", BreakpointRejected = "", LogPoint = "", Stopped = "" }
			or {
				Breakpoint = "●",
				BreakpointCondition = "⊜",
				BreakpointRejected = "⊘",
				LogPoint = "◆",
				Stopped = "⭔",
			}
		for type, icon in pairs(breakpoint_icons) do
			local tp = "Dap" .. type
			local hl = (type == "Stopped") and "DapStop" or "DapBreak"
			vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
		end

		-- Automatically open/close debug UI when debugging starts/stops
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Install golang specific config
		require("dap-go").setup({
			delve = {
				-- On Windows delve must be run attached or it crashes.
				-- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
				detached = vim.fn.has("win32") == 0,
			},
		})
	end,
}
