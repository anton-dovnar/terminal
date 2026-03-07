-- Load colorscheme persistence before Lazy so autocmds exist when LazyVim sets tokyonight
require("config.colorscheme_persist")
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
