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
