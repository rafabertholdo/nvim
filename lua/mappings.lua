require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<C-g>", ":NvimTreeToggle<CR>", { desc = "Toggle NvTree" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explorer" })

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
vim.keymap.set("v", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("v", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

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
