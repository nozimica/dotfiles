-- ---------------------------------------------------------------------------
-- yank
-- ---------------------------------------------------------------------------
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
end, { noremap = true, silent = true, desc = "Yank absolute file path"  })

-- Yank absolute directory path
vim.keymap.set( "n", "<leader>yd", function()
  local dirpath = vim.fn.expand("%:p:h")  -- :p:h = absolute path's head (dir)
  vim.fn.setreg("+", dirpath)
  vim.notify("Copied: " .. dirpath)
end, { noremap = true, silent = true, desc = "Yank absolute directory path"  })

-- ---------------------------------------------------------------------------
-- misc
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<leader>r", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
vim.keymap.set("n", "<leader>xc", "<cmd>Trouble close<cr>", { desc = "Close Trouble Window" })

-- move blocks in VISUAL mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
