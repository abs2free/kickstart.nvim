-- 设置窗口选项的默认值（可选，但通常是一个好的起点）
-- 这会确保所有新的窗口都倾向于使用 conceallevel = 0
-- vim.opt.conceallevel = 0
-- 默认情况下，许多主题和插件会设置合理的默认值，所以这一行可能不需要

-- 为 'markdown' 文件类型设置 conceallevel = 2
vim.opt_local.conceallevel = 2

vim.api.nvim_create_autocmd('FileType', {
  -- 匹配文件类型
  pattern = 'markdown',

  -- 执行回调函数
  callback = function()
    -- 这是一个窗口局部选项 (opt_local)，只影响当前缓冲区/窗口
    vim.opt_local.conceallevel = 2

    -- 可选：只在非插入模式（Normal, Visual, Select, Cmdline）下隐藏
    -- 在插入模式 (i) 下会显示隐藏的文本，方便编辑
    vim.opt_local.concealcursor = 'n'
  end,

  -- 确保每个新的 markdown 缓冲区只运行一次
  group = vim.api.nvim_create_augroup('MarkdownConceal', { clear = true }),
})

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- backup and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.config/undodir'

-- folding (for nvim-ufo)
vim.o.foldenable = true
vim.o.foldmethod = 'manual'
vim.o.foldlevel = 99
vim.o.foldcolumn = '0'

-- misc
vim.opt.isfname:append '@-@'
vim.opt.updatetime = 50
vim.opt.colorcolumn = '80'
vim.opt.clipboard:append 'unnamedplus'
vim.opt.mouse = 'a'

-- FIXME
-- TODO
