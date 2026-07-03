return {
  'wojciech-kulik/xcodebuild.nvim',
  dependencies = {
  },
  config = function()
    require('xcodebuild').setup {
      -- 确保这里没有禁用相关功能
    }
  end,
}
