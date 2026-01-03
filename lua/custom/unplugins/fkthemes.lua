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
      transparent_background = false,
    }
  end,
}
