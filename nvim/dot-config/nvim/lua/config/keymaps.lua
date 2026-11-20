-- With these (yanky handles the yank, OSC 52 copies to clipboard):
vim.keymap.set( "v", "<leader>y", function()
  vim.cmd("normal! y")  -- yanky captures this
  local text = vim.fn.getreg('"')
  vim.fn.setreg("+", text)
  vim.notify("Copied to clipboard")
end, { desc = "Yank to system clipboard" })

vim.keymap.set( "n", "<leader>yy", function()
  vim.cmd("normal! yy")  -- yanky captures this
  local text = vim.fn.getreg('"')
  vim.fn.setreg("+", text)
  vim.notify("Copied to clipboard")
end, { desc = "Yank line to system clipboard" })


-- Yank absolute file path
vim.keymap.set( "n", "<leader>yf", function()
  local filepath = vim.fn.expand("%:p")  -- :p = absolute path
  vim.fn.setreg("+", filepath)
  vim.notify("Copied: " .. filepath)
end, { noremap = true, silent = true })

-- Yank absolute directory path
vim.keymap.set( "n", "<leader>yd", function()
  local dirpath = vim.fn.expand("%:p:h")  -- :p:h = absolute path's head (dir)
  vim.fn.setreg("+", dirpath)
  vim.notify("Copied: " .. dirpath)
end, { noremap = true, silent = true })

-- Buffer navigation
vim.keymap.set("n", "gb", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "gB", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>bH', "<Cmd>BufferLineMovePrev<CR>", { desc = "Move this buffer to the Left" })
vim.keymap.set('n', '<leader>bL', "<Cmd>BufferLineMoveNext<CR>", { desc = "Move this buffer to the Right" })
vim.keymap.set('n', 'g1', function() require('bufferline').go_to(1, true) end, { desc = "Go to buffer 1" })
vim.keymap.set('n', 'g2', function() require('bufferline').go_to(2, true) end, { desc = "Go to buffer 2" })
vim.keymap.set('n', 'g3', function() require('bufferline').go_to(3, true) end, { desc = "Go to buffer 3" })
vim.keymap.set('n', 'g4', function() require('bufferline').go_to(4, true) end, { desc = "Go to buffer 4" })
vim.keymap.set('n', 'g5', function() require('bufferline').go_to(5, true) end, { desc = "Go to buffer 5" })
vim.keymap.set('n', 'g6', function() require('bufferline').go_to(6, true) end, { desc = "Go to buffer 6" })
vim.keymap.set('n', 'g7', function() require('bufferline').go_to(7, true) end, { desc = "Go to buffer 7" })
vim.keymap.set('n', 'g8', function() require('bufferline').go_to(8, true) end, { desc = "Go to buffer 8" })
vim.keymap.set('n', 'g9', function() require('bufferline').go_to(9, true) end, { desc = "Go to buffer 9" })
vim.keymap.set('n', 'g0', function() require('bufferline').go_to(10, true) end, { desc = "Go to buffer 10" })
vim.keymap.set("n", "<leader><delete>", function() Snacks.bufdelete() end, { desc = "Close Buffer" })
