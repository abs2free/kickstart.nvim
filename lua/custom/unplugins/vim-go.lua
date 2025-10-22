return {
  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoInstallBinaries",
    config = function()
      -- vim-go 配置
      vim.g.go_fmt_autosave = 1
      vim.g.go_fmt_command = "goimports"
      vim.g.go_highlight_types = 1
      vim.g.go_highlight_fields = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_function_calls = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_extra_types = 1
    end,
  }
}
