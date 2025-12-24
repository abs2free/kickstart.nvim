return {
  {
    'akinsho/toggleterm.nvim',
    opts = {
      direction = 'horizontal',
      size = 15,
      persist_size = true,
      close_on_exit = false,
    },
    config = function()
      local Terminal = require('toggleterm.terminal').Terminal

      -- 创建一个新的tmux窗格并在其中运行命令（在右侧打开，宽度20%）
      local function run_in_tmux(cmd)
        vim.fn.system 'tmux split-window -h -p 30'
        vim.fn.system('tmux send-keys "' .. cmd .. '" Enter')
      end

      -- Go run current file in tmux
      vim.keymap.set('n', '<Leader>gr', function()
        local cmd = 'go run ' .. vim.fn.bufname '%'
        run_in_tmux(cmd)
      end, { desc = 'Run current Go file' })

      -- Go test current function in tmux
      vim.keymap.set('n', '<Leader>gt', function()
        local test_name = vim.fn.expand '<cword>'
        local cmd = 'go test -run ' .. test_name .. ' -v'
        run_in_tmux(cmd)
      end, { desc = 'Run current Go test' })

      -- Store last command for reuse
      local last_command = nil

      -- Prompt for a command
      vim.keymap.set('n', '<Leader>vp', function()
        vim.ui.input({ prompt = 'Command: ' }, function(cmd)
          if cmd then
            last_command = cmd
            run_in_tmux(cmd)
          end
        end)
      end, { desc = 'Prompt for command' })

      -- Run last command
      vim.keymap.set('n', '<Leader>vl', function()
        if last_command then
          run_in_tmux(last_command)
        end
      end, { desc = 'Run last command' })

      -- Close tmux pane
      vim.keymap.set('n', '<Leader>vq', function()
        vim.fn.system 'tmux kill-pane -t +1'
      end, { desc = 'Close tmux pane' })

      -- Interrupt running command
      vim.keymap.set('n', '<Leader>vx', function()
        vim.fn.system 'tmux send-keys -t +1 C-c'
      end, { desc = 'Interrupt command' })

      -- Zoom tmux pane
      vim.keymap.set('n', '<Leader>vz', function()
        vim.fn.system 'tmux resize-pane -Z -t +1'
      end, { desc = 'Toggle zoom pane' })

      -- Clear tmux pane
      vim.keymap.set('n', '<Leader>v<C-l>', function()
        vim.fn.system 'tmux send-keys -t +1 "clear" Enter'
      end, { desc = 'Clear terminal' })

      -- Inspect runner (optional)
      vim.keymap.set('n', '<Leader>vi', function()
        -- 可以添加查看tmux窗格状态的逻辑
        vim.fn.system 'tmux display-message -p "#{pane_current_command}"'
      end, { desc = 'Inspect runner' })

      -- Optional: Add function to send any command to tmux
      function _G.SendToTmux(cmd)
        run_in_tmux(cmd)
      end

      -- Optional: Add custom layout function
      function _G.SetTmuxLayout(layout)
        vim.fn.system('tmux select-layout ' .. layout)
      end
    end,
  },
}
