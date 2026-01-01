-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Stop vim-sleuth from messing with c/cpp formatting
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function()
    vim.b.sleuth_automatic = 0 -- stop sleuth from adjusting indent
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 3
    vim.bo.tabstop = 3
    vim.bo.softtabstop = 3
  end,
})

-- Auto retab whenever textchanged
-- vim.api.nvim_create_autocmd('TextChanged', {
--   pattern = '*',
--   callback = function()
--     vim.cmd 'retab'
--   end,
-- })
--
-- Function to update winbar depending on whether the window is active
-- local function update_winbar()
--   local current_win = vim.api.nvim_get_current_win()
--   for _, win in ipairs(vim.api.nvim_list_wins()) do
--     local buf = vim.api.nvim_win_get_buf(win)
--     local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
--     local config = vim.api.nvim_win_get_config(win)
--
--     -- Skip floating windows and special filetypes like Telescope
--     if config.relative == '' and ft ~= 'TelescopePrompt' and ft ~= 'TelescopeResults' then
--       if win == current_win then
--         vim.api.nvim_set_option_value('winbar', '', { win = win })
--       else
--         local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':t')
--         vim.api.nvim_set_option_value('winbar', '%#WinBarInactive#  ' .. filename, { win = win })
--       end
--     end
--   end
-- end
--
-- -- Update winbar when window focus changes
-- vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter', 'WinLeave' }, {
--   callback = update_winbar,
-- })
--
-- There's more autocmds spread in plugins folder
