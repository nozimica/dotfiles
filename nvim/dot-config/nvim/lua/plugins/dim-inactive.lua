-- lua/plugins/dim-inactive.lua
return {
  {
    "levouh/tint.nvim",
    event = "VeryLazy",
    opts = {
      -- Inactive windows: subtract 70 from each RGB channel (0-255, clamped)
      -- of foreground and underline (sp) colors, after tint's default 0.7
      -- desaturation. Backgrounds are left alone unless
      -- tint_background_colors = true.
      tint = -70,
      -- A positive value brightens instead, e.g., tint = 30
      focus_change_events = {
        -- SafeState resyncs the current window when a plugin closes a window
        -- from a non-nested autocmd (e.g. Snacks closing LazyGit on
        -- TermClose), which skips WinEnter/WinClosed and leaves it dimmed.
        focus = { "WinEnter", "SafeState" },
        unfocus = { "WinLeave" },
      },
    },
  },
}
