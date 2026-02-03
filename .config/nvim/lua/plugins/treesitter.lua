return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',
  dependency = { 'nvim-treesitter/nvim-treesitter-textobjects', lazy = true },
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'java',
      'diff',
      'python',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'javascript',
      'typescript',
      'css',
    },
    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = '<C-space>',
    --     node_incremental = '<C-space>',
    --     scope_incremental = false,
    --     node_decremental = '<bs>',
    --   },
    -- },
    -- Autoinstall languages that are not installed
    auto_install = false,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    -- textobjects = {
    --   select = {
    --     enable = true,
    --     lookahead = true,
    --     keymaps = {
    --       ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
    --       ['i='] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
    --       ['l='] = { query = '@assignment.lhs', desc = 'Select left hand side of an assignment' },
    --       -- ['r='] = { query = '@assignment.rhs', desc = 'Select right hand side of an assignment' },
    --
    --       -- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
    --       -- ['a:'] = { query = '@property.outer', desc = 'Select outer part of an object property' },
    --       -- ['i:'] = { query = '@property.inner', desc = 'Select inner part of an object property' },
    --       -- ['l:'] = { query = '@property.lhs', desc = 'Select left part of an object property' },
    --       -- ['r:'] = { query = '@property.rhs', desc = 'Select right part of an object property' },
    --
    --       -- ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/argument' },
    --       -- ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },
    --
    --       -- ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
    --       -- ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },
    --
    --       -- ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop' },
    --       -- ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },
    --       --
    --       -- ['af'] = { query = '@call.outer', desc = 'Select outer part of a function call' },
    --       -- ['if'] = { query = '@call.inner', desc = 'Select inner part of a function call' },
    --       --
    --       -- ['am'] = { query = '@function.outer', desc = 'Select outer part of a method/function definition' },
    --       -- ['im'] = { query = '@function.inner', desc = 'Select inner part of a method/function definition' },
    --       --
    --       -- ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class' },
    --       -- ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class' },
    --     },
    --   },
    -- },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
