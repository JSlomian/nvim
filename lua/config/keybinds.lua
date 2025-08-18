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


-- window movement with j k l ;  (left, down, up, right)
local map = function(lhs, rhs) vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true }) end
map("<C-w>j", "<C-w>h")  -- left
map("<C-w>k", "<C-w>j")  -- down
map("<C-w>l", "<C-w>k")  -- up
map("<C-w>;", "<C-w>l")  -- right
map("<C-w>'", "<C-w>l")  -- right


local tmap = function(lhs, rhs) vim.keymap.set("t", lhs, rhs, { noremap = true, silent = true }) end
tmap("<C-w>j", [[<C-\><C-n><C-w>h]])
tmap("<C-w>k", [[<C-\><C-n><C-w>j]])
tmap("<C-w>l", [[<C-\><C-n><C-w>k]])
tmap("<C-w>;", [[<C-\><C-n><C-w>l]])
tmap("<C-w>'", [[<C-\><C-n><C-w>l]])


vim.keymap.set("n", "<leader>q", function()
  local listed = vim.fn.getbufinfo({ buflisted = 1 })
  if #listed > 1 then
    vim.cmd("bdelete")
  else
    vim.cmd("quit")
  end
end, { desc = "Close buffer or quit" })
