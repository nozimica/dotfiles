-- Register OSC 52 as the clipboard provider (for + and * registers)
-- but do NOT set vim.o.clipboard = "unnamedplus"
-- This means only explicit "+y / "+p (or <leader>y / <leader>p) use macOS clipboard
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

-- Java: 4-space indent (Amazon standard)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.expandtab = true
  end,
})

-- Performance: reduce per-scroll redraw cost (makes Ctrl-e/Ctrl-y match Vim speed)
vim.o.synmaxcol = 500
vim.o.regexpengine = 1

-- Disable LazyVim's format-on-save (the authoritative toggle)
vim.g.autoformat = false
