return {
  {
    -- 这个 plugin 不需要安装，只是用来组织配置
    'neovim/nvim-lspconfig',

    config = function()
      -- ⭐ gopls 独立配置（Neovim 0.11+ 新 API）
      vim.lsp.config('gopls', {
        cmd = { 'gopls' },

        filetypes = { 'go', 'gomod', 'gowork' },

        root_dir = vim.fs.root(0, {
          'go.work',
          'go.mod',
          '.git',
        }),

        settings = {
          gopls = {
            gofumpt = false,
            staticcheck = true,

            analyses = {
              unusedparams = true,
              nilness = true,
              shadow = true,
            },

            usePlaceholders = true,
            completeUnimported = true,
          },
        },
      })

      vim.lsp.enable 'gopls'
    end,
  },
}
