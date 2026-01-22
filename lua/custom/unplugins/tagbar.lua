return {
  'preservim/tagbar',
  cmd = 'TagbarToggle',
  keys = {
    { '<leader>tb', '<cmd>TagbarToggle<CR>', desc = 'Toggle Tagbar' },
  },
  config = function()
    -- tagbar 配置
    vim.g.tagbar_width = 30
    vim.g.tagbar_autofocus = 1
    vim.g.tagbar_sort = 0
    -- 可选：为特定文件类型自动打开
    -- vim.cmd([[
    --   autocmd FileType c,cpp,python,javascript,typescript,go nested :TagbarOpen
    -- ]])
  end,
}
