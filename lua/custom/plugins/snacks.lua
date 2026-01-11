return {
  'wojciech-kulik/xcodebuild.nvim',
  dependencies = {
    -- 必须安装 snacks.nvim 以支持图片渲染
    {
      'folke/snacks.nvim',
      opts = {
        image = {
          enabled = true, -- 开启图片支持
          -- 可以在这里配置图片渲染后端，通常默认即可
          -- backend = "ghostty",
        },
      },
    },
  },
  config = function()
    require('xcodebuild').setup {
      -- 确保这里没有禁用相关功能
    }
  end,
}
