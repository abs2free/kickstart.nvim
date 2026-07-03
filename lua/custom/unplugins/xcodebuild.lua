return {
  'wojciech-kulik/xcodebuild.nvim',
  dependencies = {
    -- Uncomment a picker that you want to use, snacks.nvim might be additionally
    -- useful to show previews and failing snapshots.

    -- You must select at least one:
    'nvim-telescope/telescope.nvim',
    -- "ibhagwan/fzf-lua",
	
    -- (optional) to show previews
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

    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-tree.lua', -- (optional) to manage project files
    'stevearc/oil.nvim', -- (optional) to manage project files
    'nvim-treesitter/nvim-treesitter', -- (optional) for Quick tests support (required Swift parser)
    'mfussenegger/nvim-dap', -- 必须
    'rcarriga/nvim-dap-ui', -- 推荐
  },
  config = function()
    require('xcodebuild').setup {
      -- put some options here or leave it empty to use default settings
    }
  end,
}
