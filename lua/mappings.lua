require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<C-g>", ":NvimTreeToggle<CR>", { desc = "Toggle NvTree" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explorer" })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Debugger
vim.keymap.set("n", "<C-b>", "<cmd>DapToggleBreakpoint <CR>", { desc = "Toggle breakpoint" }) --  move current buffer to new tab
--vim.keymap.set("n", "<C-A-y>", "<cmd>DapContinue <CR>", { desc = "Start or continue the debugger" }) --  move current buffer to new tab
vim.keymap.set("n", "<F6>", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<F7>", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
vim.keymap.set("n", "<F8>", "<cmd>DapStepOut<CR>", { desc = "Step out" })

-- Move
-- vim.keymap.set("v", "<C-d>", "<C-d>zz", { noremap = true })
-- vim.keymap.set("v", "<C-u>", "<C-u>zz", { noremap = true })
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- vim.keymap.set("n", "J", "mzJ`z")

local dap_helper = require("dap-helper")
local dap = require("dap")
vim.keymap.set("n", "<F5>", function()
	-- Check if debuggger is already running
	if #dap.status() == 0 and dap_helper.get_build_cmd() then
		local ret = os.execute(dap_helper.get_build_cmd() .. " > /dev/null 2>&1")
		if ret ~= 0 then
			vim.notify("Build failed", vim.log.levels.ERROR)
			return
		end
	end
	dap.continue()
end)

-- vim.keymap.set(
-- 	"n",
-- 	"<leader>dt",
-- 	"<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>",
-- 	{ desc = "Toggle breakpoint", noremap = true, silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>dz",
-- 	"<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>",
-- 	{ desc = "Set conditional Breakpoint", noremap = true, silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>dc",
-- 	"<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>",
-- 	{ desc = "clear all breakpoints", noremap = true, silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>dl",
-- 	"<cmd>lua require('persistent-breakpoints.api').set_log_point()<cr>",
-- 	{ desc = "Set log point", noremap = true, silent = true }
-- )
--
--
-- primeagen

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
	require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a')

vim.keymap.set("n", "<leader>ef", 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj')

vim.keymap.set("n", "<leader>el", 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i')

vim.keymap.set("n", "<leader>ca", function()
	require("cellular-automaton").start_animation("make_it_rain")
end)

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
