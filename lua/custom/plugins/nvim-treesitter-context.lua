return {
  -- 插件的 GitHub 仓库名
  'nvim-treesitter/nvim-treesitter-context',

  -- 确保 nvim-treesitter 插件已加载
  dependencies = { 'nvim-treesitter/nvim-treesitter' },

  -- 当文件类型是支持的语言时，启用插件
  ft = {
    'ada',
    'apex',
    'bash',
    'c',
    'c_sharp',
    'capnp',
    'clojure',
    'cmake',
    'cpp',
    'css',
    'cuda',
    'cue',
    'd',
    'dart',
    'devicetree',
    'diff',
    'elixir',
    'elm',
    'enforce',
    'fennel',
    'fish',
    'fortran',
    'gdscript',
    'glimmer',
    'glsl',
    'go',
    'graphql',
    'groovy',
    'haskell',
    'html',
    'ini',
    'janet_simple',
    'java',
    'javascript',
    'json',
    'jsonnet',
    'julia',
    'kdl',
    'kotlin',
    'latex',
    'liquidsoap',
    'lua',
    'make',
    'markdown',
    'matlab',
    'nim',
    'nix',
    'nu',
    'objdump',
    'ocaml',
    'ocaml_interface',
    'odin',
    'php',
    'php_only',
    'prisma',
    'proto',
    'python',
    'r',
    'ruby',
    'rust',
    'scala',
    'scss',
    'smali',
    'solidity',
    'starlark',
    'svelte',
    'swift',
    'tact',
    'tcl',
    'teal',
    'templ',
    'terraform',
    'toml',
    'tsx',
    'typescript',
    'typoscript',
    'typst',
    'usd',
    'verilog',
    'vhdl',
    'vim',
    'vue',
    'xml',
    'yaml',
    'yang',
    'zig',
  },

  -- 插件配置
  opts = {
    enable = true, -- 启用此插件
    max_lines = 3, -- 上下文窗口最多显示 3 行
    line_numbers = true, -- 显示行号
    multiline_threshold = 20, -- 超过 20 行的上下文不显示，防止过长
    trim_scope = 'outer', -- 当超过 max_lines 时，优先丢弃外层上下文
    mode = 'cursor', -- 使用光标所在行来计算上下文
    separator = '─', -- 上下文和内容之间的分隔符
    zindex = 20, -- 浮动窗口的 Z-index
  },

  -- 可选：添加快捷键（例如跳转到上下文）
  keys = {
    {
      '[c',
      function()
        require('treesitter-context').go_to_context(vim.v.count1)
      end,
      mode = 'n',
      desc = 'Go to context',
    },
  },

  -- 可选：配置高亮组来自定义外观
  -- 在 LazyVim 中，你可以在 theme.lua 或 colorscheme 文件中设置，
  -- 或者直接在配置的 `config` 函数中设置。
  config = function(_, opts)
    require('treesitter-context').setup(opts)

    -- 示例：自定义上下文窗口和行号的颜色
    -- 默认 TreesitterContext 链接到 NormalFloat
    -- vim.cmd.hi('TreesitterContextLineNumber guifg=#6C7086') -- 设置行号颜色
    -- vim.cmd.hi('TreesitterContextBottom gui=underline guisp=Grey') -- 在上下文底部添加灰色下划线
  end,
}
