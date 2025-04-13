local dap = require "dap"

dap.configurations.swift = {
  {
    name = "Launch file",
    type = "debugserver",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
dap.adapters.debugserver = {
  type = "server",
  -- host = "127.0.0.1",
  --port = 13000, -- ?? Use the port printed out or specified with `--port`
  port = "13000",
  executable = {
    command = "/home/rafabertholdo/.local/share/nvim/mason/bin/codelldb",
    args = {
      "--port",
      "13000",
      "--liblldb",
      "/home/rafabertholdo/.local/share/swiftly/toolchains/6.1.0/usr/lib/liblldb.so.17.0",
    },
  },
}
