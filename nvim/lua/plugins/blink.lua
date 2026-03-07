return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or { "lsp", "path", "buffer" }
      opts.sources.providers = opts.sources.providers or {}

      -- 1. Remove from default sources if present
      opts.sources.default = vim.tbl_filter(function(source)
        return source ~= "blink-copilot" and source ~= "copilot"
      end, opts.sources.default)

      -- 2. Remove provider definition entirely
      opts.sources.providers["blink-copilot"] = nil
      opts.sources.providers["copilot"] = nil

      return opts
    end,
  },
}
