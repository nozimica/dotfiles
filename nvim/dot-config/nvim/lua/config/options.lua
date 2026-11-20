-- Register OSC 52 as the clipboard provider (for + and * registers)
-- but do NOT set vim.o.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = function()
      return vim.fn.getreg("+")
    end,
    ["*"] = function()
      return vim.fn.getreg("*")
    end,
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
