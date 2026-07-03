return {
  'rmagatti/auto-session',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    -- 使用命令行的形式，会自动触发内置的 session-lens (Telescope)
    { '<leader>wr', '<cmd>AutoSession search<CR>', desc = 'Session search' },
    { '<leader>ws', '<cmd>AutoSession save<CR>', desc = 'Save session' },
    { '<leader>wa', '<cmd>AutoSession toggle<CR>', desc = 'Toggle autosave' },
    { '<leader>wL', '<cmd>AutoSession restore<CR>', desc = 'Restore session' },
  },

  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    -- 1. 设置你要求的保存路径
    root_dir = vim.fn.expand '~/.vim/sessions/',

    -- 2. 核心行为配置
    auto_save = true,
    auto_restore = true,
    auto_restore_last_session = false, -- 设为 false，只有进入目录才恢复
    log_level = 'error',

    -- 3. 控制不触发自动保存的目录
    suppress_dirs = { '~/Desktop', '~/Downloads' },

    auto_clean_after_session_restore = true,

    session_lens = {
      picker = 'telescope', -- 显式指定使用 telescope
      load_on_setup = true,

      mappings = {
        delete_session = { 'i', '<C-d>' },
        alternate_session = { 'i', '<C-s>' },
        copy_session = { 'i', '<C-y>' },
      },

      picker_opts = {
        -- 这里配置 Telescope 的视觉样式
        theme = 'dropdown', -- 使用掉落式窗口，更美观
        border = true,
        layout_config = {
          width = 0.8,
          height = 0.5,
        },
        previewer = false, -- 搜索 Session 时通常不需要预览文件内容
      },
    },
  },

  -- 初始化前确保目录存在
  init = function()
    local session_dir = vim.fn.expand '~/.vim/sessions/'
    if vim.fn.isdirectory(session_dir) == 0 then
      vim.fn.mkdir(session_dir, 'p')
    end
  end,
}
