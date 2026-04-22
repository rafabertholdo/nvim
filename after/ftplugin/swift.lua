-- Swift-specific keybindings and settings

-- Store last build output for viewing later
local last_build_output = ""

-- Function to show build logs
local function show_build_logs()
	if #last_build_output == 0 then
		vim.notify("No build logs available", vim.log.levels.WARN)
		return
	end

	vim.cmd("split")
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(last_build_output, "\n"))
	vim.api.nvim_set_current_buf(buf)
	vim.bo[buf].filetype = "swiftbuild"
	vim.cmd("resize 15")
end

-- Swift Package Manager build function for iOS
local function swift_build_ios()
	local swift_path = vim.fn.system("xcrun -f swift"):gsub("\n", "")
	local cmd = string.format(
		"%s build --triple arm64-apple-ios --swift-sdk arm64-apple-ios -Xswiftc -suppress-warnings -c release -Xswiftc -Onone",
		swift_path
	)

	vim.notify("Building Swift Package for iOS...", vim.log.levels.INFO)

	-- Run command and capture output
	local output = vim.fn.system(cmd .. " 2>&1")
	local exit_code = vim.v.shell_error
	last_build_output = output

	if exit_code == 0 then
		vim.notify("✓ Build succeeded (use <leader>pl to view logs)", vim.log.levels.INFO)
		return true
	else
		vim.notify("✗ Build failed (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
		-- Auto-show errors on failure
		show_build_logs()
		return false
	end
end

-- Swift Package Manager build function (default/debug)
local function swift_build()
	vim.notify("Building Swift Package...", vim.log.levels.INFO)

	-- Run command and capture output
	local output = vim.fn.system("swift build 2>&1")
	local exit_code = vim.v.shell_error
	last_build_output = output

	if exit_code == 0 then
		vim.notify("✓ Build succeeded (use <leader>pl to view logs)", vim.log.levels.INFO)
		return true
	else
		vim.notify("✗ Build failed (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
		-- Auto-show errors on failure
		show_build_logs()
		return false
	end
end

-- Build project (Swift Package Manager)
vim.keymap.set("n", "<leader>pb", swift_build, { buffer = true, desc = "Swift: Build SPM package (debug)" })
vim.keymap.set("n", "<leader>pbi", swift_build_ios, { buffer = true, desc = "Swift: Build SPM for iOS (release)" })
vim.keymap.set("n", "<leader>pl", show_build_logs, { buffer = true, desc = "Swift: Show build logs" })

-- For iOS debugging with xcodebuild.nvim:
-- 1. Use <leader>iI to configure project (select scheme/device)
-- 2. Use <C-D-y> or F5 to start debugging (or <leader>ir to build & run)
-- The executable path is automatically detected from DerivedData
