-- lazy.nvim
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    -- 针对 nvim-notify 进行正确配置
    {
      'rcarriga/nvim-notify',
      opts = {
        background_colour = '#000000', -- 在这里指定背景色，防止它去抓取未初始化的透明高亮组
      },
    },
  },
}
