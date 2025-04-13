return {
  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  max_concurrent_installers = 10,
  ensure_installed = {
    "codelldb",
    "swiftlint",
  },
}
