-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'present.nvim',
    dir = vim.fn.expand '~/dev/code/present.nvim',
    config = function()
      require('present').setup {}
    end,
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    'tpope/vim-rails',
    ft = { 'ruby', 'eruby', 'haml', 'slim' },
    dependencies = {
      'tpope/vim-bundler',
      'tpope/vim-rake',
    },
    config = function()
      -- vim-rails is a Vimscript plugin and doesn't need explicit setup
      -- It auto-detects Rails projects and provides commands like :A, :R, :Emodel, etc.
    end,
  },
}
