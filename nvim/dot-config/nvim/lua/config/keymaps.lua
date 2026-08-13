-- Copy to macOS clipboard (OSC 52) with <leader>y
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Buffer navigation
vim.keymap.set("n", "gb", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "gB", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
