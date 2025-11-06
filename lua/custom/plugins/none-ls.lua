return
-- none-ls 集成 goimports + golines 格式化
{
  'nvimtools/none-ls.nvim',
  opts = function(_, opts)
    local null_ls = require 'null-ls'
    opts.sources = opts.sources or {}

    vim.list_extend(opts.sources, {
      null_ls.builtins.completion.spell,

      -- 静态检查 golangci-lint 为诊断工具
      null_ls.builtins.diagnostics.golangci_lint,
    })
  end,
}
