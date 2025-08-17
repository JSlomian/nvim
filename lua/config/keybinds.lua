-- Remap movement in ALL three modes: normal (n), visual (x), operator-pending (o)
local m = { 'n', 'x', 'o' }

-- Use native motions so counts & operators work (d3k, y5;, c2l, etc.)
vim.keymap.set(m, 'j', 'h') -- j -> left
vim.keymap.set(m, 'k', 'j') -- k -> down
vim.keymap.set(m, 'l', 'k') -- l -> up
vim.keymap.set(m, ';', 'l') -- ; -> right
vim.keymap.set(m, "'", 'l') -- ' -> right
--[[
  For my Sweep https://github.com/davidphilipbarr/Sweep/tree/main/Sweep%20v2.2
  with Miryoku QWERTY https://github.com/manna-harbour/miryoku
  ]] --
