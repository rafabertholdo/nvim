function ColorMyPencils(color)
	color = color or "xcodedarkhc"
	vim.cmd.colorscheme(color)
end

return {
	{
		"erikbackman/brightburn.vim",
	},

	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = false,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true,
				contrast = "",
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
		end,
	},

	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "storm",
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					sidebars = "dark",
					floats = "dark",
				},
			})
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
	},

	{
		"letorbi/vim-colors-modern-borland",
		config = function()
			ColorMyPencils()
		end,
	},

	{
		"lunacookies/vim-colors-xcode",
	},
}
