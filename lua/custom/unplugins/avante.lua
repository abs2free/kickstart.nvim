return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false,
  build = 'make', -- Windows 用户改为: "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"

  opts = {
    -- ==========================================
    -- 🤖 模型提供商设置
    -- ==========================================
    auto_suggestions_provider = 'ollama',
    debug = true,
    provider = 'ollama',

    -- 👇 这里是针对新版本的配置更新：放在 providers 字段里
    providers = {
      ollama = {
        __inherited_from = 'openai',
        api_key_name = '',
        -- 注意：即便这里写了 endpoint，parse_curl_args 内部有时也无法通过 opts 访问到它
        endpoint = 'http://127.0.0.1:11434/v1',
        model = 'gpt-oss:120b-cloud',
        disable_tools = true,
      },

      --   gemini = {
      --     -- 👇 正确的 base endpoint，不要加 /models
      --     -- endpoint = 'https://generativelanguage.googleapis.com/v1beta',
      --     -- 推荐使用最新的模型
      --     model = 'gemini-2.5-flash',
      --     timeout = 30000, -- 请求超时时间(毫秒)
      --     temperature = 0, -- 0 表示让模型输出更加稳定、一致的代码
      --     max_tokens = 8192,
      --   },
    },

    -- ==========================================
    -- ⚙️ 行为设置
    -- ==========================================
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
    },

    -- ==========================================
    -- ⌨️ 快捷键映射 (默认)
    -- ==========================================
    mappings = {
      diff = {
        ours = 'co',
        theirs = 'ct',
        all_theirs = 'ca',
        both = 'cb',
        cursor = 'cc',
        next = ']x',
        prev = '[x',
      },
      suggestion = {
        accept = '<M-l>',
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
      jump = {
        next = ']]',
        prev = '[[',
      },
      submit = {
        normal = '<CR>',
        insert = '<C-s>',
      },
      sidebar = {
        apply_all = 'A',
        apply_cursor = 'a',
        switch_windows = '<Tab>',
        reverse_switch_windows = '<S-Tab>',
      },
    },

    -- ==========================================
    -- 🪟 UI 与窗口设置
    -- ==========================================
    windows = {
      position = 'right',
      wrap = true,
      width = 30,
      sidebar_header = {
        enabled = true,
        align = 'center',
        rounded = true,
      },
      input = {
        prefix = '> ',
        height = 8,
      },
    },
  },

  -- ==========================================
  -- 📦 必备与增强依赖项
  -- ==========================================
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-tree/nvim-web-devicons',
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
