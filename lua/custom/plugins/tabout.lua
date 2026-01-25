return {
  'abecodes/tabout.nvim',
  lazy = false,
  config = function()
    require('tabout').setup {
      tabkey = '<Tab>', -- 绑定的按键
      backwards_tabkey = '<S-Tab>', -- 反向跳出的按键
      act_as_tab = true, -- 如果不在括号边缘，则表现为普通 Tab
      completion = true, -- 重要：设置为 true，以便让补全插件优先处理
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = '(', close = ')' },
        { open = '{', close = '}' },
        { open = '[', close = ']' },
      },
      ignore_beginning = true, -- 在行首时直接作为普通 Tab 使用
    }
  end,
  -- 确保它在补全插件之后加载，或者在插入模式启动前加载
  event = 'InsertEnter',
  dependencies = { -- 依赖项
    'nvim-treesitter/nvim-treesitter',
  },
}
