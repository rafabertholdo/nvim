local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    swift = { "swift-format" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    async = false,
    lsp_fallback = true,
  },
}

return options
