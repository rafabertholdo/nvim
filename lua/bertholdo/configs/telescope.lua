local telescope = require("telescope")

telescope.setup({
	defaults = {
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = " ",
		path_display = { "smart" },
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.80,
		},
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--glob=!.git/",
		},
	},

	pickers = {
		find_files = {
			hidden = true,
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git/" },
		},
		live_grep = {
			additional_args = function()
				return { "--hidden", "--glob=!.git/" }
			end,
		},
	},

	extensions = {},
})

pcall(telescope.load_extension, "fzf")
