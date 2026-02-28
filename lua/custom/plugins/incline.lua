return {
  'b0o/incline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'stevearc/aerial.nvim' },
  event = 'VeryLazy',
  config = function()
    local devicons = require 'nvim-web-devicons'
    require('incline').setup {
      hide = {
        only_win = false,
      },
      window = {
        margin = { vertical = 0, horizontal = 1 },
        placement = { vertical = 'top', horizontal = 'right' },
      },
      render = function(props)
        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local filename = vim.fn.fnamemodify(bufname, ':t')
        if filename == '' then
          filename = '[No Name]'
        end

        local ext = vim.fn.fnamemodify(bufname, ':e')
        local icon, icon_color = devicons.get_icon(filename, ext, { default = true })
        local modified = vim.bo[props.buf].modified

        -- 🚀 修复核心：正确提取 Aerial 节点名称
        local success, aerial = pcall(require, 'aerial')
        local location = ''
        if success then
          local loc = aerial.get_location(true)

          -- 检查返回值是否为 table 并且不为空
          if type(loc) == 'table' and #loc > 0 then
            local path_names = {}
            -- 遍历 Aerial 返回的对象数组
            for _, item in ipairs(loc) do
              -- 提取每个节点对象中的 name 属性
              if item.name then
                table.insert(path_names, item.name)
              end
            end

            -- 如果成功提取到了名称，就拼成面包屑
            if #path_names > 0 then
              location = ' ⟩ ' .. table.concat(path_names, ' ⟩ ')
            end
          end
        end

        return {
          { ' ', icon, ' ', guifg = icon_color },
          { filename, gui = modified and 'bold' or 'none' },
          { location, guifg = '#888888' }, -- 灰色显示代码面包屑
          modified and { ' [+]', guifg = '#ff9e64' } or '',
          ' ',
        }
      end,
    }
  end,
}
