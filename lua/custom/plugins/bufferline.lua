return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy', -- 确保在 UI 元素加载后启动
  opts = {
    options = {
      mode = 'buffers',
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          seperator = true,
        },
      },
    },
  },
}
