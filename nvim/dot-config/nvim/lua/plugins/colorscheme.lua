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
