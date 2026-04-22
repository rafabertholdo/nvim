local cmp = require("cmp")

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
		["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "lazydev", group_index = 0 },
	}, {
		{ name = "buffer" },
	}),
})
