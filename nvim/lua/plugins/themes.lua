return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = false,
        },
      })
      -- Uncomment one to use as default:
      -- vim.cmd("colorscheme github_dark_default")
      -- vim.cmd("colorscheme github_light_default")
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    config = function()
      require("rose-pine").setup({
        variant = "moon", -- or "main" / "dawn"
        disable_background = true, -- 💡 key line for transparency
        disable_float_background = true, -- optional: makes popups transparent
        disable_italics = false,
      })

      vim.cmd("colorscheme rose-pine")
    end,
  },
}
