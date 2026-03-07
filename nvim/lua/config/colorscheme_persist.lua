-- Loaded before LazyVim so our autocmds exist when LazyVim sets tokyonight.
-- (User config/autocmds.lua is loaded on VeryLazy when nvim is started with no file.)

local state_file = vim.fn.stdpath("state") .. "/colorscheme.txt"

local function read_saved_colorscheme()
  local ok, lines = pcall(vim.fn.readfile, state_file)
  if not ok or not lines or #lines == 0 then
    return nil
  end
  local name = vim.trim(lines[1]):gsub("%s+", "")
  return (name ~= "") and name or nil
end

local function apply_saved_colorscheme()
  local saved = read_saved_colorscheme()
  if saved then
    pcall(vim.cmd, "colorscheme " .. saved)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("persist_colorscheme", { clear = true }),
  callback = function()
    local name = vim.g.colors_name
    if not name or name == "" then
      return
    end
    if name:match("^tokyonight") then
      local saved = read_saved_colorscheme()
      if saved and saved ~= name then
        vim.defer_fn(apply_saved_colorscheme, 0)
        return
      end
    end
    vim.fn.writefile({ name }, state_file)
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("restore_colorscheme", { clear = true }),
  callback = function()
    vim.defer_fn(apply_saved_colorscheme, 50)
  end,
})
