-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'wojciech-kulik/xcodebuild.nvim',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
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
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
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

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'codelldb', -- 添加C语言调试器
      },
    }

    local xcodebuild = require 'xcodebuild.integrations.dap'
    xcodebuild.setup()

    -- 修复：使用 Autocmd 仅在 Swift 文件中覆盖按键
    -- 避免全局覆盖 <leader>b，导致调试其他语言时报错
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'swift',
      callback = function()
        vim.keymap.set('n', '<leader>b', xcodebuild.toggle_breakpoint, { buffer = true, desc = 'Xcode: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>B', xcodebuild.toggle_message_breakpoint, { desc = 'Toggle Message Breakpoint' })
        vim.keymap.set('n', '<leader>dd', xcodebuild.build_and_debug, { buffer = true, desc = 'Xcode: Build & Debug' })
        vim.keymap.set('n', '<leader>dx', xcodebuild.terminate_session, { buffer = true, desc = 'Xcode: Terminate' })
        vim.keymap.set('n', '<leader>dr', xcodebuild.debug_without_build, { desc = 'Debug Without Building' })
        vim.keymap.set('n', '<leader>dt', xcodebuild.debug_tests, { desc = 'Debug Tests' })
        vim.keymap.set('n', '<leader>dT', xcodebuild.debug_class_tests, { desc = 'Debug Class Tests' })
      end,
    })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    }

    -- Change breakpoint icons
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

    -- 添加C语言调试配置
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb',
        args = { '--port', '${port}' },
      },
    }

    dap.configurations.c = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          -- 获取当前文件名(不含扩展名)
          local fileName = vim.fn.expand '%:t:r'
          -- 获取当前文件所在目录
          local filePath = vim.fn.expand '%:p:h'
          -- 组合可执行文件完整路径
          local exePath = filePath .. '/' .. fileName

          -- Windows系统下需要加.exe后缀
          if vim.fn.has 'win32' == 1 then
            exePath = exePath .. '.exe'
          end

          -- 如果可执行文件不存在，先编译
          if vim.fn.filereadable(exePath) == 0 then
            -- 获取源文件完整路径
            local sourceFile = vim.fn.expand '%:p'
            -- 编译命令
            local cmd = string.format('gcc -g %s -o %s', sourceFile, exePath)
            -- 执行编译
            vim.fn.system(cmd)

            -- 检查编译是否成功
            if vim.v.shell_error ~= 0 then
              print 'Compilation failed!'
              return nil
            end
          end

          return exePath
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- 添加 Go 调试配置
    dap.configurations.go = {
      {
        type = 'go',
        name = 'Debug Package',
        request = 'launch',
        program = '${fileDirname}',
      },
      {
        type = 'go',
        name = 'Debug Test',
        request = 'launch',
        mode = 'test',
        program = '${fileDirname}',
      },
      {
        type = 'go',
        name = 'Debug Test (go.mod)',
        request = 'launch',
        mode = 'test',
        program = './${relativeFileDirname}',
      },
    }

    -- 配置 Go 调试适配器
    dap.adapters.go = {
      type = 'executable',
      command = 'dlv',
      args = { 'dap', '-l', '127.0.0.1:${port}' },
    }

    -- 修改 dap-go 的设置
    require('dap-go').setup {
      -- 调试器配置
      dap_configurations = {
        {
          type = 'go',
          name = 'Debug Package',
          request = 'launch',
          program = '${fileDirname}',
        },
      },
      -- delve配置
      delve = {
        initialize_timeout_sec = 20,
        port = '${port}',
        args = {},
        build_flags = '',
        -- Windows系统需要设置为false
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
