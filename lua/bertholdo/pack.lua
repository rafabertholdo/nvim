-- Plugin management via vim.pack (Neovim 0.12+ built-in).
-- Plugins land under: stdpath("data")/site/pack/core/opt/<name>
-- Update with :lua vim.pack.update()

-- Post-install / post-update build hooks. Registered BEFORE vim.pack.add so
-- they fire on the very first install too.
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("BertholdoPackHooks", { clear = true }),
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end

		if name == "nvim-treesitter" then
			-- Update/install parsers after the plugin itself has been updated.
			vim.schedule(function()
				local ok, ts = pcall(require, "nvim-treesitter")
				if ok and ts.update then
					pcall(ts.update)
				end
			end)
		elseif name == "telescope-fzf-native.nvim" then
			vim.system({ "make" }, { cwd = ev.data.path }):wait()
		end
	end,
})

vim.pack.add({
	-- Core libs
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/christoomey/vim-tmux-navigator",

	-- Colorschemes
	"https://github.com/erikbackman/brightburn.vim",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/folke/tokyonight.nvim",
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
	"https://github.com/letorbi/vim-colors-modern-borland",
	"https://github.com/lunacookies/vim-colors-xcode",

	-- Treesitter
	"https://github.com/nvim-treesitter/nvim-treesitter",

	-- Telescope
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",

	-- LSP / completion / mason
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/folke/lazydev.nvim",

	-- Formatting
	"https://github.com/stevearc/conform.nvim",

	-- DAP
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/jay-babu/mason-nvim-dap.nvim",
	"https://github.com/daic0r/dap-helper.nvim",
	"https://github.com/mfussenegger/nvim-jdtls",

	-- Xcode / iOS
	"https://github.com/wojciech-kulik/xcodebuild.nvim",

	-- UI
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/moll/vim-bbye",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/folke/zen-mode.nvim",

	-- Git
	"https://github.com/tpope/vim-fugitive",

	-- Misc / fun
	"https://github.com/eandrju/cellular-automaton.nvim",
	"https://github.com/ThePrimeagen/vim-with-me",
	"https://github.com/theprimeagen/vim-be-good",
	"https://github.com/nvzone/volt",
	"https://github.com/nvzone/typr",
})

-- Load per-plugin setup modules. Order matters for things like LSP
-- capabilities (cmp must be set up so lsp can pull defaults from cmp-nvim-lsp).
local modules = {
	"colors",
	"treesitter",
	"telescope",
	"mason",
	"lazydev",
	"cmp",
	"lsp",
	"conform",
	"lualine",
	"bufferline",
	"nvim-tree",
	"fugitive",
	"trouble",
	"which-key",
	"zenmode",
	"fidget",
	"dap",
	"dap-ui",
	"xcode",
	"typr",
}

for _, name in ipairs(modules) do
	local ok, err = pcall(require, "bertholdo.configs." .. name)
	if not ok then
		vim.notify("Failed to load bertholdo.configs." .. name .. ": " .. err, vim.log.levels.ERROR)
	end
end
