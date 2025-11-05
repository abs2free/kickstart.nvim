return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {},
  -- 💡 关键修复：config 函数确保 'flash' 模块在 require 时是可用的
  config = function()
    -- Override the `flash.jump` function to detect start and end
    local flash = require 'flash'
    local original_jump = flash.jump

    flash.jump = function(opts)
      vim.api.nvim_exec_autocmds('User', { pattern = 'FlashJumpStart' })
      -- print("flash.nvim enter")

      -- 调用原始的跳转函数
      original_jump(opts)

      vim.api.nvim_exec_autocmds('User', { pattern = 'FlashJumpEnd' })
      -- print("flash.nvim leave")
    end
  end,
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      -- press y+r
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
