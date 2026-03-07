-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Persist colorscheme across restarts
local state_file = vim.fn.stdpath("state") .. "/colorscheme.txt"

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("persist_colorscheme", { clear = true }),
  callback = function()
    local name = vim.g.colors_name
    if name and name ~= "" then
      vim.fn.writefile({ name }, state_file)
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("restore_colorscheme", { clear = true }),
  callback = function()
    vim.defer_fn(function()
      local ok, lines = pcall(vim.fn.readfile, state_file)
      if not ok or not lines or #lines == 0 then
        return
      end
      local name = vim.trim(lines[1]):gsub("%s+", "")
      if name ~= "" then
        pcall(vim.cmd, "colorscheme " .. name)
      end
    end, 50)
  end,
})
