return {
  'flashcodes-themayankjha/fkthemes.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
    -- Add your themes here
  },
  config = function()
    require('fkthemes').setup {
      themes = { 'sonokai', 'catppuccin', 'gruvbox', 'tokyonight-night', 'tokyonight-storm', 'tokyonight-moon', 'tokyonight-day' },
      default_theme = 'gruvbox',
      transparent_background = true,
    }
  end,
}
