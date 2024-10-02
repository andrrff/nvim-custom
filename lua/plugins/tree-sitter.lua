return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "c_sharp" },
			indent = { enabled = false },
			highlight = { enabled = true },
			sync_install = false,
			auto_install = true,
			modules = {
				"lua",
				"c_sharp",
			},
			ignore_install = { "c", "cpp", "python" },
		})
	end,
}
