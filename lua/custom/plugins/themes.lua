return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = true,
      }
    end,
  },
  {
    'morhetz/gruvbox',
    config = function()
      -- vim.cmd.colorscheme 'gruvbox'
    end,
  },
  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.sonokai_enable_italic = true
      -- vim.cmd.colorscheme('sonokai')
    end,
  },
  { 'EdenEast/nightfox.nvim' },
  { 'rebelot/kanagawa.nvim' },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup {}
    end,
  },
}
