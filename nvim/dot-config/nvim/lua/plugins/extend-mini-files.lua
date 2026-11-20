return {
  -- Plain options, deep-merged by lazy.nvim on top of LazyVim's mini-files extra.
  -- width_preview is the desired width; the spec below shrinks it to fit the screen.
  {
    "nvim-mini/mini.files",
    opts = {
      windows = {
        width_preview = 70,
        -- Not a mini.files option: width of the preview window when it lists a directory.
        -- width_preview then only applies to file previews.
        width_preview_dir = 30,
        -- width_nofocus = 15,
      },
    },
  },

  -- Workaround: mini.files hides the preview entirely when
  -- width_focus + width_preview + borders > vim.o.columns, instead of shrinking it.
  -- This fragment runs after the table above, so opts already holds the merged values.
  {
    "nvim-mini/mini.files",
    opts = function(_, opts)
      local desired = opts.windows.width_preview
      local desired_dir = opts.windows.width_preview_dir
      local width_focus = opts.windows.width_focus

      -- Room left after the focused window, with 2 border columns per window
      local function fit(width)
        width = width or desired
        return math.max(10, math.min(width, vim.o.columns - (width_focus + 2) - 2))
      end

      opts.windows.width_preview = fit()

      vim.api.nvim_create_autocmd("VimResized", {
        group = vim.api.nvim_create_augroup("minifiles_fit_preview", { clear = true }),
        callback = function()
          local w = fit()
          MiniFiles.config.windows.width_preview = w -- used by the next open()
          MiniFiles.refresh({ windows = { width_preview = w } }) -- fixes an explorer that's already open
        end,
      })

      -- mini.files has a single width_preview for file and directory previews, and also
      -- uses it to decide how many columns fit. When the preview window's width doesn't
      -- match what its content needs, refresh the explorer with the right width_preview
      -- so the column layout is computed with it too. The width check stops the loop:
      -- the refresh fires this event again, and then the widths match.
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("minifiles_dir_preview_width", { clear = true }),
        pattern = "MiniFilesWindowUpdate",
        callback = function(args)
          if desired_dir == nil or not MiniFiles.config.windows.preview then return end
          local state = MiniFiles.get_explorer_state()
          if state == nil then return end

          local preview_path = state.branch[state.depth_focus + 1]
          if preview_path == nil then return end

          local win_id = args.data.win_id
          for _, win in ipairs(state.windows) do
            if win.win_id == win_id and win.path == preview_path then
              -- An empty folder's preview is a placeholder path ending in NUL ("-No-fs-entry-").
              -- vim.fn.isdirectory() throws E976 on it, so size it as the folder's listing.
              local is_placeholder = preview_path:sub(-1) == "\0"
              local is_dir = is_placeholder or vim.fn.isdirectory(preview_path) == 1
              local wanted = is_dir and fit(desired_dir) or fit()
              if vim.api.nvim_win_get_width(win_id) ~= wanted then
                vim.schedule(function()
                  MiniFiles.refresh({ windows = { width_preview = wanted } })
                  -- If the new width drops columns, mini.files closes a leftover window that
                  -- still shows the focused buffer, and window_close() unregisters that buffer
                  -- from the window it was just moved to. Cursor moves then stop updating the
                  -- preview. A second refresh re-registers every buffer and closes nothing.
                  MiniFiles.refresh()
                end)
              end
              return
            end
          end
        end,
      })

      return opts
    end,
  },
}
