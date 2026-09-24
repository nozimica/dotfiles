return {
  -- add themes
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
    config = function()
      require('nordic').load({})
    end
  },
  {
    "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
    },
  },
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "medium",
      })
    end,
  },
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    ---@type solarized.config
    opts = {},
    config = function(_, opts)
      vim.o.termguicolors = true
      vim.o.background = 'dark'
      require('solarized').setup(opts)
      vim.cmd.colorscheme 'solarized'
    end,
  },

  -- Configure LazyVim to load one of them
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  }
}
