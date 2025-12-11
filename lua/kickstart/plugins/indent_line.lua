return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    dependencies = {
      'HiPhish/rainbow-delimiters.nvim', -- 添加依赖
    },
    config = function()
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }

      local hooks = require 'ibl.hooks'
      -- 创建高亮组
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
      end)

      require('ibl').setup {
        indent = {
          char = '│',
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = true,
          injected_languages = true,
          highlight = highlight,
          priority = 500,
        },
        whitespace = {
          remove_blankline_trail = true,
        },
        exclude = {
          filetypes = {
            'help',
            'dashboard',
            'packer',
            'NvimTree',
            'Trouble',
            'TelescopePrompt',
            'Float',
          },
          buftypes = {
            'terminal',
            'nofile',
            'quickfix',
            'prompt',
          },
        },
      }
    end,
  },
  {
    'HiPhish/rainbow-delimiters.nvim', -- 添加 rainbow-delimiters 插件
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'RainbowRed',
          'RainbowYellow',
          'RainbowBlue',
          'RainbowOrange',
          'RainbowGreen',
          'RainbowViolet',
          'RainbowCyan',
        },
      }
    end,
  },
}
