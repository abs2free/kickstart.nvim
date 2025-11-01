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
      add = 'gsa', -- Add surrounding in Normal and Visual modes
      delete = 'gsd', -- Delete surrounding
      find = 'gsf', -- Find surrounding (to the right)
      find_left = 'gsF', -- Find surrounding (to the left)
      highlight = 'gsh', -- Highlight surrounding
      replace = 'gsr', -- Replace surrounding

      suffix_last = 'gl', -- Suffix to search with "prev" method
      suffix_next = 'gn', -- Suffix to search with "next" method
    },
  },
}
