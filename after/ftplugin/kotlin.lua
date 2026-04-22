local root = vim.fs.root(0, {
	"settings.gradle.kts",
	"settings.gradle",
	"build.gradle.kts",
	"build.gradle",
	"gradle.properties",
	".git",
}) or vim.fn.getcwd()

local gradlew = vim.fn.filereadable(root .. "/gradlew") == 1 and "./gradlew" or "gradle"

local function run_in_terminal(command, opts)
	opts = opts or {}
	vim.cmd("botright 12split")
	local bufnr = vim.api.nvim_get_current_buf()
	vim.fn.jobstart(command, {
		term = true,
		on_exit = function(_, code, _)
			if opts.on_exit then
				vim.schedule(function()
					opts.on_exit(code, bufnr)
				end)
			end
		end,
	})
	vim.cmd("startinsert")
end

local function run_gradle(task)
	local command = "cd " .. vim.fn.shellescape(root) .. " && " .. gradlew .. " " .. task
	run_in_terminal(command)
end

local function detect_android_studio_module()
	local workspace = vim.fs.find(".idea/workspace.xml", { path = root, upward = true })[1]
	if not workspace then
		return nil
	end

	local ok, lines = pcall(vim.fn.readfile, workspace)
	if not ok then
		return nil
	end

	local content = table.concat(lines, "\n")
	return content:match('<component name="RunManager" selected="Android App%.([^"]+)"')
end

local function default_android_package_for_variant(variant)
	local lower_variant = variant:lower()
	local package_name = lower_variant:find("pj", 1, true) and "br.com.Inter.CDPro" or "br.com.intermedium"

	if lower_variant:find("debug", 1, true) then
		package_name = package_name .. ".dev"
	end

	return package_name
end

local function set_android_target(module_name, variant)
	local package_name = default_android_package_for_variant(variant)

	vim.g.android_module = module_name
	vim.b.android_module = module_name
	vim.g.android_variant = variant
	vim.b.android_variant = variant
	vim.g.android_package_name = package_name
	vim.b.android_package_name = package_name
end

local function android_target(prompt)
	local default_module = vim.b.android_module or vim.g.android_module or detect_android_studio_module() or "app"
	local default_variant = vim.b.android_variant or vim.g.android_variant or "InterHmgDebug"

	if prompt then
		local module_name = vim.fn.input("Android module: ", default_module)
		if module_name == nil or module_name == "" then
			return nil
		end

		local variant = vim.fn.input("Android variant: ", default_variant)
		if variant == nil or variant == "" then
			return nil
		end

		set_android_target(module_name, variant)
		return module_name, variant
	end

	set_android_target(default_module, default_variant)
	return default_module, default_variant
end

local function android_task(task_prefix, prompt)
	local module_name, variant = android_target(prompt)
	if not module_name or not variant then
		return nil
	end

	return ":" .. module_name .. ":" .. task_prefix .. variant
end

local function android_package()
	local _, variant = android_target(false)
	local package_name = vim.b.android_package_name
		or vim.g.android_package_name
		or default_android_package_for_variant(variant or "InterHmgDebug")

	if package_name == "" then
		package_name = vim.fn.input("Android package: ")
	end

	if package_name == nil or package_name == "" then
		return nil
	end

	vim.g.android_package_name = package_name
	vim.b.android_package_name = package_name
	return package_name
end

local function android_debug_port()
	return tonumber(vim.b.android_debug_port or vim.g.android_debug_port or 8700)
end

local function open_dap_ui()
	local ok, dapui = pcall(require, "dapui")
	if ok then
		dapui.open({ reset = true })
	end
end

local function trim(text)
	return (text or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

local function run_system(command, callback)
	vim.system(command, { text = true }, function(obj)
		vim.schedule(function()
			callback(obj.code, trim(obj.stdout), trim(obj.stderr))
		end)
	end)
end

local function ensure_android_debug_support()
	local ok, jdtls = pcall(require, "bertholdo.configs.jdtls")
	if not ok then
		vim.notify("nvim-jdtls is not available yet. Restart Neovim after Lazy installs it.", vim.log.levels.ERROR)
		return nil
	end

	local client, err = jdtls.ensure_for_root(root)
	if not client then
		vim.notify(err, vim.log.levels.ERROR)
		return
	end

	return client
end

local function wait_for_java_adapter(attempts, callback)
	local ok, dap = pcall(require, "dap")
	if ok and dap.adapters.java then
		callback(true)
		return
	end

	if attempts <= 0 then
		callback(false)
		return
	end

	vim.defer_fn(function()
		wait_for_java_adapter(attempts - 1, callback)
	end, 250)
end

local function start_android_dap_session()
	local ok, dap = pcall(require, "dap")
	if not ok then
		vim.notify("nvim-dap is not available.", vim.log.levels.ERROR)
		return
	end

	wait_for_java_adapter(20, function(ready)
		if not ready then
			vim.notify("Java debug adapter is not ready yet. Restart Neovim after Mason finishes installing it.", vim.log.levels.ERROR)
			return
		end

		dap.run({
			type = "java",
			request = "attach",
			name = "Android Debug (Attach)",
			hostName = "127.0.0.1",
			port = android_debug_port(),
		})
	end)
end

local function forward_android_debug_port(package_name, attempts, callback)
	attempts = attempts or 20

	run_system({ "adb", "shell", "pidof", "-s", package_name }, function(code, stdout, stderr)
		local pid = trim(stdout)
		if code == 0 and pid ~= "" then
			local port = android_debug_port()
			vim.g.android_debug_package = package_name
			vim.b.android_debug_package = package_name
			vim.g.android_debug_port = port
			vim.b.android_debug_port = port

			run_system({ "adb", "forward", "--remove", "tcp:" .. port }, function()
				run_system({ "adb", "forward", "tcp:" .. port, "jdwp:" .. pid }, function(forward_code, _, forward_stderr)
					if forward_code ~= 0 then
						vim.notify("Failed to forward Android debug port: " .. forward_stderr, vim.log.levels.ERROR)
						return
					end

					callback()
				end)
			end)
			return
		end

		if attempts <= 0 then
			vim.notify(
				"Could not find the Android process to attach the debugger. " .. stderr,
				vim.log.levels.ERROR
			)
			return
		end

		vim.defer_fn(function()
			forward_android_debug_port(package_name, attempts - 1, callback)
		end, 500)
	end)
end

local function try_attach_debugger(package_name)
	local client = ensure_android_debug_support()
	if not client then
		return
	end

	forward_android_debug_port(package_name, 20, function()
		open_dap_ui()
		start_android_dap_session()
	end)
end

local function map(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { buffer = true, desc = desc })
end

map("<leader>ab", function()
	local task = android_task("assemble", false)
	if task then
		run_gradle(task)
	end
end, "Android build selected variant")

map("<leader>ai", function()
	local task = android_task("install", false)
	if task then
		run_gradle(task)
	end
end, "Android install selected variant")

map("<leader>ar", function()
	local task = android_task("install", false)
	local package_name = android_package()
	if not task or not package_name then
		return
	end

	local command = table.concat({
		"cd " .. vim.fn.shellescape(root),
		gradlew .. " " .. task,
		"adb shell am clear-debug-app",
		"adb shell monkey -p "
			.. vim.fn.shellescape(package_name)
			.. " -c android.intent.category.LAUNCHER 1",
	}, " && ")

	run_in_terminal(command)
end, "Android install and run selected variant")

map("<leader>ad", function()
	local task = android_task("install", false)
	local package_name = android_package()
	if not task or not package_name then
		return
	end

	local command = table.concat({
		"cd " .. vim.fn.shellescape(root),
		gradlew .. " " .. task,
		"adb shell am set-debug-app -w " .. vim.fn.shellescape(package_name),
		"adb shell monkey -p "
			.. vim.fn.shellescape(package_name)
			.. " -c android.intent.category.LAUNCHER 1",
	}, " && ")

	run_in_terminal(command, {
		on_exit = function(code)
			if code ~= 0 then
				return
			end

			try_attach_debugger(package_name)
		end,
	})
end, "Android install and debug")

map("<leader>at", function()
	local task = android_task("test", false)
	if task then
		run_gradle(task .. "UnitTest")
	end
end, "Android test selected variant")

map("<leader>al", function()
	local task = android_task("lint", false)
	if task then
		run_gradle(task)
	end
end, "Android lint selected variant")

map("<leader>aa", function()
	local module_name, variant = android_target(true)
	if module_name and variant then
		vim.notify("Android target: :" .. module_name .. " " .. variant, vim.log.levels.INFO)
	end
end, "Android choose module and variant")

map("<leader>ag", function()
	local task = vim.fn.input("Gradle task: ")
	if task ~= nil and task ~= "" then
		run_gradle(task)
	end
end, "Android run gradle task")
