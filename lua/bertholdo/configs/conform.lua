require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		kotlin = { "ktlint" },
		swift = { "swiftformat" },
		xml = { "xmlformat" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},

	formatters = {
		swiftformat = {
			command = "swift-format",
			args = { "format", "$FILENAME", "--in-place" },
			range_args = function(_, ctx)
				return { "--offsets", ctx.range.start[1] .. ":" .. ctx.range["end"][1] }
			end,
			stdin = false,
		},
	},
})
