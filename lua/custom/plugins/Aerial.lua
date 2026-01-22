return {
  'stevearc/aerial.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('aerial').setup {
      -- 这里是调整宽度的核心配置
      layout = {
        -- 1. 设置最大宽度：可以是数字(列数)或小数(屏幕比例)
        -- 这里意思是：最大不超过 80 列，或者屏幕宽度的 40%
        max_width = { 80, 0.4 },

        -- 2. 设置理想宽度：如果不设置(nil)，它会根据内容自动适应，直到达到 max_width
        -- 如果你想要一个固定的宽度，比如总是 50 列，就填 50
        width = nil,

        -- 3. 设置最小宽度：防止太窄，建议设为 30 或 40
        min_width = 40,

        -- 4. 关键功能：根据内容自动调整宽度
        -- 如果设为 true，每次打开它都会尝试包含所有文字（直到 max_width）
        -- 对于 Swift 这种长命名的语言非常有用！
        resize_to_content = true,
      },
      -- 自动在 Swift 文件打开时加载
      on_attach = function(bufnr)
        -- 绑定快捷键，比如 <leader>a 打开大纲
        vim.keymap.set('n', '<leader>tb', '<cmd>AerialToggle!<CR>', { buffer = bufnr })
      end,
    }
  end,
}
