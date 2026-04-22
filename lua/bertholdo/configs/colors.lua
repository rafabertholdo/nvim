-- Colorscheme configuration. Install specs live in bertholdo/pack.lua.

function ColorMyPencils(color)
	color = color or "xcodedarkhc"
	vim.cmd.colorscheme(color)
end

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

ColorMyPencils()
