return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.cmd 'filetype plugin indent on'
    vim.cmd 'syntax enable'
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_compiler_method = 'latexmk'
    -- vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_compiler_latexmk = {
      continuous = 1,
      options = {
        '-pdf',
        '-interaction=nonstopmode',
        '-synctex=1',
        '-file-line-error',
        '-halt-on-error',
        '-quiet',
      },
    }
  end,
}
