return {
  'L3MON4D3/LuaSnip',
  version = '2.*',
  build = (function()
    -- Build Step is needed for regex support in snippets.
    -- This step is not supported in many windows environments.
    -- Remove the below condition to re-enable on windows.
    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
      return
    end
    return 'make install_jsregexp'
  end)(),
  config = function()
    -- 加载自定义 VSCode 格式的 snippets
    require('luasnip.loaders.from_vscode').lazy_load {
      paths = { '~/.config/nvim/lua/custom/snippets' },
    }

    -- 可以在这里进行其他 LuaSnip 的配置，例如设置映射、选项等
    -- 例如: ls.setup({})
  end,
}
