return {
  'chomosuke/typst-preview.nvim',
  lazy = false, -- or ft = 'typst'
  version = '1.*',
  keys = {
    { '<leader>tp', '<cmd>TypstPreviewToggle<cr>', desc = 'Typst: Preview' },
  },
  opts = {
    dependencies_bin = { ['tinymist'] = 'tinymist' },
    open_cmd = 'open -a "Brave Browser" --args %s',
  },
}
