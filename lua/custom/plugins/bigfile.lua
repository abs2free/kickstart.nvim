return {
  -- 不需要填外部 github 仓库，利用 lazy.nvim 的 config 机制直接运行原生代码
  dir = vim.fn.stdpath 'config',
  event = 'BufReadPre',
  config = function()
    vim.api.nvim_create_autocmd('BufReadPre', {
      pattern = '*',
      callback = function(ev)
        local max_filesize = 50 * 1024 * 1024 -- 50 MiB
        local ok, stats = pcall(vim.loop.fs_stat, ev.file)
        if ok and stats and stats.size > max_filesize then
          -- 发现大文件，立即关闭耗费性能的特性
          vim.opt_local.swapfile = false
          vim.opt_local.foldmethod = 'manual'
          vim.opt_local.undofile = false

          -- 关闭语法高亮
          vim.cmd 'syntax clear'

          -- 如果安装了 treesitter，关闭当前 buffer 的 treesitter
          local ts_status, ts_highlighter = pcall(require, 'nvim-treesitter.highlighter')
          if ts_status and ts_highlighter.active[ev.buf] then
            vim.cmd 'TSBufDisable highlight'
          end

          -- 提示用户
          vim.notify('检测到大文件，已自动关闭 LSP/Treesitter 以优化性能。', vim.log.levels.WARN)
        end
      end,
    })
  end,
}
