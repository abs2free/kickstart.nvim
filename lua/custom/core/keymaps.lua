local opts = { noremap = true, silent = true }

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'moves lines down in visual selection' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'moves lines up in visual selection' })

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'move down in buffer with cursor centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'move up in buffer with cursor centered' })
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- tab stuff
vim.keymap.set('n', '<leader>to', '<cmd>tabnew<CR>') --open new tab
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>') --close current tab
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<CR>') --go to next
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<CR>') --go to pre
vim.keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>') --open current tab in new tab

--split management
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
-- split window vertically
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
-- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' }) -- make split windows equal width & height
-- close current split window
vim.keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })

-- Copy filepath to the clipboard
vim.keymap.set('n', '<leader>fp', function()
  local filePath = vim.fn.expand '%:~' -- Gets the file path relative to the home directory
  vim.fn.setreg('+', filePath) -- Copy the file path to the clipboard register
  print('File path copied to clipboard: ' .. filePath) -- Optional: print message to confirm
end, { desc = 'Copy file path to clipboard' })

-- Keymaps
vim.keymap.set('n', '<leader>pWs', function()
  local builtin = require 'telescope.builtin'
  local word = vim.fn.expand '<cWORD>'
  builtin.grep_string { search = word }
end, { desc = 'Find Connected Words under cursor' })

vim.keymap.set('n', '<leader>ths', '<cmd>Telescope themes<CR>', { noremap = true, silent = true, desc = 'Theme Switcher' })

-- xcodebuild
vim.keymap.set('n', '<leader>X', '<cmd>XcodebuildPicker<cr>', { desc = 'Show Xcodebuild Actions' })
vim.keymap.set('n', '<leader>xf', '<cmd>XcodebuildProjectManager<cr>', { desc = 'Show Project Manager Actions' })

vim.keymap.set('n', '<leader>xb', '<cmd>XcodebuildBuild<cr>', { desc = 'Build Project' })
vim.keymap.set('n', '<leader>xB', '<cmd>XcodebuildBuildForTesting<cr>', { desc = 'Build For Testing' })
vim.keymap.set('n', '<leader>xr', '<cmd>XcodebuildBuildRun<cr>', { desc = 'Build & Run Project' })

vim.keymap.set('n', '<leader>xt', '<cmd>XcodebuildTest<cr>', { desc = 'Run Tests' })
vim.keymap.set('v', '<leader>xt', '<cmd>XcodebuildTestSelected<cr>', { desc = 'Run Selected Tests' })
vim.keymap.set('n', '<leader>xT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Run Current Test Class' })
vim.keymap.set('n', '<leader>x.', '<cmd>XcodebuildTestRepeat<cr>', { desc = 'Repeat Last Test Run' })

vim.keymap.set('n', '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Toggle Xcodebuild Logs' })
vim.keymap.set('n', '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', { desc = 'Toggle Code Coverage' })
vim.keymap.set('n', '<leader>xC', '<cmd>XcodebuildShowCodeCoverageReport<cr>', { desc = 'Show Code Coverage Report' })
vim.keymap.set('n', '<leader>xe', '<cmd>XcodebuildTestExplorerToggle<cr>', { desc = 'Toggle Test Explorer' })
vim.keymap.set('n', '<leader>xs', '<cmd>XcodebuildFailingSnapshots<cr>', { desc = 'Show Failing Snapshots' })

vim.keymap.set('n', '<leader>xp', '<cmd>XcodebuildPreviewGenerateAndShow<cr>', { desc = 'Generate Preview' })
vim.keymap.set('n', '<leader>x<cr>', '<cmd>XcodebuildPreviewToggle<cr>', { desc = 'Toggle Preview' })

vim.keymap.set('n', '<leader>xd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select Device' })
vim.keymap.set('n', '<leader>xq', '<cmd>Telescope quickfix<cr>', { desc = 'Show QuickFix List' })

vim.keymap.set('n', '<leader>xx', '<cmd>XcodebuildQuickfixLine<cr>', { desc = 'Quickfix Line' })
vim.keymap.set('n', '<leader>xa', '<cmd>XcodebuildCodeActions<cr>', { desc = 'Show Code Actions' })

-- 使用 H 和 L 快速切换左右 Buffer
vim.keymap.set('n', 'H', ':bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', 'L', ':bnext<cr>', { desc = 'Next Buffer' })
-- 关闭当前 Buffer
-- 如果安装了 bufdelete 插件
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete Buffer (Keep Layout)' })

vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')

vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

vim.keymap.set('n', '<A-S-l>', '<cmd>BufferLineMoveNext<cr>', { desc = '将当前标签向右移' })
vim.keymap.set('n', '<A-S-h>', '<cmd>BufferLineMovePrev<cr>', { desc = '将当前标签向左移' })

-- Normal 模式：Ctrl + / 切换注释 (终端中 <C-/> 通常发送的是 <C-_>)
vim.keymap.set('n', '<C-_>', 'gcc', { remap = true })
-- Visual 模式：Ctrl + / 切换注释
vim.keymap.set('v', '<C-_>', 'gc', { remap = true })
