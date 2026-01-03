return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
  lazy = true,
  enabled = true,
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diff view' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File history' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Branch history' },
    { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = 'Close diff' },
  },
  config = function()
    require('diffview').setup {
      enhanced_diff_hl = true,
      view = {
        default = { layout = 'diff2_horizontal' },
        merge_tool = { layout = 'diff3_horizontal' },
      },
      file_panel = {
        listing_style = 'tree',
        win_config = { width = 35 },
      },
    }
  end,
}
