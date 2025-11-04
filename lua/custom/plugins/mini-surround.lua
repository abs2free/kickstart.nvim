-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/mini-surround.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/mini-surround.lua
--
-- I'm just using lazyvim.org defaults here
-- This plugin comes installed by default, but it was removed one time, so just
-- leaving it here because I want to always have it installed
--
-- https://github.com/echasnovski/mini.surround
--
return {
  'nvim-mini/mini.surround',
  recommended = true,
  opts = {
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      add = 'sa', -- Add surrounding in Normal and Visual modes
      delete = 'sd', -- Delete surrounding
      find = 'sf', -- Find surrounding (to the right)
      find_left = 'sF', -- Find surrounding (to the left)
      highlight = 'sh', -- Highlight surrounding
      replace = 'sr', -- Replace surrounding

      suffix_last = 'l', -- Suffix to search with "prev" method
      suffix_next = 'n', -- Suffix to search with "next" method
    },
  },
}
