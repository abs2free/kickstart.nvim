return {
  'LunarVim/bigfile.nvim',
  event = 'BufReadPre',
  opts = {
    filesize = 50, -- filesize in MiB
  },
  config = function(_, opts)
    require('bigfile').setup(opts)
  end,
}
