return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/todo-comments.nvim' },
  opts = {
    focus = true,
  },
  config = function()
    require('trouble').setup {
      auto_open = false,
      auto_close = false,
      auto_preview = true,
      auto_jump = false,
      mode = 'quickfix',
      severity = vim.diagnostic.severity.ERROR,
      cycle_results = false,
    }
  end,
  cmd = 'Trouble',
  keys = {
    { '<leader>xw', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Open trouble workspace diagnostics' },
    {
      '<leader>xd',
      '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
      desc = 'Open trouble document diagnostics',
    },
    { '<leader>xq', '<cmd>Trouble quickfix toggle<CR>', desc = 'Open trouble quickfix list' },
    { '<leader>xl', '<cmd>Trouble loclist toggle<CR>', desc = 'Open trouble location list' },
    { '<leader>xt', '<cmd>Trouble todo toggle<CR>', desc = 'Open todos in trouble' },
  },
}
