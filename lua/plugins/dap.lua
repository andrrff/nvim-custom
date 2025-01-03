return {
	"mfussenegger/nvim-dap",
	recommended = true,
	dependencies = {
		"rcarriga/nvim-dap-ui",
		-- virtual text for the debugger
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},
	},
	keys = {
		{ "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Breakpoint Condition",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>da",
			function()
				require("dap").continue({ before = get_args })
			end,
			desc = "Run with Args",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{
			"<leader>dg",
			function()
				require("dap").goto_()
			end,
			desc = "Go to Line (No Execute)",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>dj",
			function()
				require("dap").down()
			end,
			desc = "Down",
		},
		{
			"<leader>dk",
			function()
				require("dap").up()
			end,
			desc = "Up",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
		{
			"<leader>ds",
			function()
				require("dap").session()
			end,
			desc = "Session",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Widgets",
		},
	},
	config = function()
		local dap = require("dap")
		if not dap.adapters["netcoredbg"] then
			require("dap").adapters["netcoredbg"] = {
				type = "executable",
				command = vim.fn.exepath("netcoredbg"),
				args = { "--interpreter=vscode" },
				options = {
					detached = false,
				},
			}
		end
		if not dap.adapters["coreclr"] then
			require("dap").adapters["coreclr"] = {
				type = "executable",
				command = vim.fn.exepath("netcoredbg"),
				args = { "--interpreter=vscode" },
				options = {
					detached = false,
				},
			}
		end
		for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
			if not dap.configurations[lang] then
				dap.configurations[lang] = {
					{
						type = "netcoredbg",
						name = "Launch file",
						request = "launch",
						---@diagnostic disable-next-line: redundant-parameter
						program = function()
							return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
					},
          {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
              return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            end,
          },
          {
            type = "coreclr",
            name = "attach - netcoredbg",
            request = "attach",
            processId = require('dap.utils').pick_process,
          }
				}
			end
		end
	end,
}
