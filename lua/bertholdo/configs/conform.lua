local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		swift = { "swiftformat" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 1000,
		async = false,
		lsp_fallback = false,
	},

	formatters = {
		swiftformat = {
			-- This can be a string or a function that returns a string.
			-- When defining a new formatter, this is the only field that is required
			command = "swift-format",
			-- A list of strings, or a function that returns a list of strings
			-- Return a single string instead of a list to run the command in a shell
			args = { "format", "$FILENAME" },
			-- If the formatter supports range formatting, create the range arguments here
			-- range_args = function(self, ctx)
			-- return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
			-- end,
			-- Send file contents to stdin, read new contents from stdout (default true)
			-- When false, will create a temp file (will appear in "$FILENAME" args). The temp
			-- file is assumed to be modified in-place by the format command.
			stdin = true,
			-- A function that calculates the directory to run the command in
			-- cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
			-- When cwd is not found, don't run the formatter (default false)
			require_cwd = true,
			-- When stdin=false, use this template to generate the temporary file that gets formatted
			tmpfile_format = ".conform.$RANDOM.$FILENAME",
			-- Exit codes that indicate success (default { 0 })
			exit_codes = { 0, 1 },
			-- Environment variables. This can also be a function that returns a table.
			env = {
				VAR = "value",
			},
			-- Set to false to disable merging the config with the base definition
			inherit = true,
			-- When inherit = true, add these additional arguments to the beginning of the command.
			-- This can also be a function, like args
			-- prepend_args = { "--use-tabs" },
			-- When inherit = true, add these additional arguments to the end of the command.
			-- This can also be a function, like args
			-- append_args = { "--trailing-comma" },
		},
	},
}

return options
