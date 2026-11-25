return {
  { "ellisonleao/gruvbox.nvim" },
  { "Rigellute/rigel" },
  { "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      custom_highlights = function(c)
        -- Each powerline arrow is a glyph whose fg is the tab color and bg the fill
        -- behind it (or the reverse), so every Sign/SignRight pair must use the
        -- exact same colors as its tab and as TabLineFill.
        local fill = c.mantle
        local function tab(state, bg, fg, extra)
          local base = vim.tbl_extend("force", { bg = bg, fg = fg }, extra or {})
          return {
            ["Buffer" .. state] = base,
            ["Buffer" .. state .. "Index"] = base,
            ["Buffer" .. state .. "Mod"] = vim.tbl_extend("force", base, { fg = c.red }),
            ["Buffer" .. state .. "Target"] = { bg = bg, fg = c.red, bold = true },
            ["Buffer" .. state .. "Sign"] = { bg = bg, fg = fill },
            ["Buffer" .. state .. "SignRight"] = { bg = fill, fg = bg },
          }
        end
        return vim.tbl_extend(
          "force",
          { TabLineFill = { bg = fill }, BufferTabpageFill = { bg = fill, fg = c.overlay0 } },
          tab("Current", c.blue, c.mantle, { bold = true }),
          tab("Visible", c.surface1, c.blue),
          tab("Inactive", c.surface0, c.overlay1),
          tab("Alternate", c.surface0, c.subtext0)
        )
      end,
    },
  },
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
  },

  -- Configure LazyVim to load one of them
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "nordic",
      colorscheme = "catppuccin-mocha",
    },
  }
}
