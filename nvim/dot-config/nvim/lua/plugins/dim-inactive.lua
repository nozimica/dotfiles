-- lua/plugins/dim_inactive.lua
return {
  {
    "levouh/tint.nvim",
    event = "VeryLazy",
    opts = {
      -- Darken inactive windows by 30%
      tint = -70,
      -- You can also brighten with a positive value, e.g., tint = 30
    },
  },
}
