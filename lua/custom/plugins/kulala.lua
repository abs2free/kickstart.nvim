return {
  'mistweaverco/kulala.nvim',
  keys = {
    {
      '<leader>Rs',
      function()
        require('kulala').run()
      end,
      desc = 'Send request',
    },
    {
      '<leader>Ra',
      function()
        require('kulala').run_all()
      end,
      desc = 'Send all requests',
    },
    {
      '<leader>Rb',
      function()
        require('kulala').scratchpad()
      end,
      desc = 'Open scratchpad',
    },
    {
      '<leader>Ri',
      function()
        require('kulala').import()
      end,
      desc = 'Import (Postman/OpenAPI)',
    },
    {
      '<leader>Re',
      function()
        require('kulala').export()
      end,
      desc = 'Export to Postman',
    },
  },
  -- 确保包含 json 用于导入，http/rest 用于导出
  ft = { 'http', 'rest', 'json' },
  opts = {
    global_keymaps = false,
    lsp = { formatter = true },
  },
}
