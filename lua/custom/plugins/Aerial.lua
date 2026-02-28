return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('aerial').setup {
      -- 优先级：Tree-sitter 通常对 SwiftUI 的结构反应最快
      backends = { 'treesitter', 'lsp', 'markdown', 'man' },

      layout = {
        max_width = { 80, 0.4 },
        min_width = 40,
        resize_to_content = true,
      },

      -- 关键配置：包含 SwiftUI 必需的符号类型
      filter_kind = {
        'Class',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct', -- 识别 struct ContentView
        'Variable', -- 识别 var body
        'Property', -- 某些 LSP 会将 body 识别为 Property
      },

      -- 自动加载
      on_attach = function(bufnr)
        -- 在 normal 模式下使用 ,tb 切换大纲 (因为你的 leader 是逗号)
        vim.keymap.set('n', '<leader>tb', '<cmd>AerialToggle!<CR>', { buffer = bufnr, desc = 'Toggle [T]ree [B]ar (Aerial)' })

        -- 快速在符号间跳转
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
    }
  end,
}
