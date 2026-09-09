-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
-- Configured for Go and C/C++ debugging.

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you automatically
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Golang DAP helper plugin
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- 基础调试按键
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },

    -- 断点相关
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Conditional Breakpoint',
    },

    -- 调试控制扩展 (类似原 Xcode 快捷键风格)
    {
      '<leader>dd',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<leader>dx',
      function()
        require('dap').terminate()
      end,
      desc = 'Debug: Terminate Session',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.toggle()
      end,
      desc = 'Debug: Toggle REPL',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'Debug: Run Last Session',
    },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: Toggle DAP UI',
    },
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Mason DAP 自动安装与配置
    require('mason-nvim-dap').setup {
      automatic_installation = true,

      -- 提供给 handlers 的额外配置（可为空，交给下方特定插件/配置处理）
      handlers = {},

      -- 自动确保安装的调试器 adapter
      ensure_installed = {
        'delve', -- Golang 调试器
        'codelldb', -- C/C++ 调试器
      },
    }

    -- Dap UI 设置
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    }

    -- 调试启动/结束时自动打开和关闭 DAP UI
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- 断点高亮与图标设置
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    ---------------------------------------------------------------------------
    -- Golang 调试配置 (使用 nvim-dap-go)
    ---------------------------------------------------------------------------
    require('dap-go').setup {
      delve = {
        initialize_timeout_sec = 20,
        port = '${port}',
        args = {},
        build_flags = '',
        -- Windows系统需要设置为false
        detached = vim.fn.has 'win32' == 0,
      },
    }

    ---------------------------------------------------------------------------
    -- C / C++ 调试配置 (使用 codelldb)
    ---------------------------------------------------------------------------
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb',
        args = { '--port', '${port}' },
      },
    }

    local c_cpp_config = {
      {
        name = 'Launch current file (Auto Compile)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          -- 获取当前文件名(不含扩展名)与文件路径
          local fileName = vim.fn.expand '%:t:r'
          local filePath = vim.fn.expand '%:p:h'
          local exePath = filePath .. '/' .. fileName

          -- Windows系统下补充 .exe 后缀
          if vim.fn.has 'win32' == 1 then
            exePath = exePath .. '.exe'
          end

          -- 如果可执行文件不存在，自动进行编译 (支持 gcc / g++)
          if vim.fn.filereadable(exePath) == 0 then
            local sourceFile = vim.fn.expand '%:p'
            local compiler = (vim.bo.filetype == 'cpp') and 'g++' or 'gcc'
            local cmd = string.format('%s -g "%s" -o "%s"', compiler, sourceFile, exePath)

            vim.fn.system(cmd)

            if vim.v.shell_error ~= 0 then
              vim.notify('Compilation failed!', vim.log.levels.ERROR)
              return nil
            end
          end

          return exePath
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
      {
        name = 'Launch executable (Manual Select)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    dap.configurations.c = c_cpp_config
    dap.configurations.cpp = c_cpp_config
  end,
}
