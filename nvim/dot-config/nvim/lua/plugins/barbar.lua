-- lua/plugins/barbar.lua
return {
  "romgrk/barbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  keys = {
    -- ---------------------------------------------------------------------------
    -- Navigation
    -- ---------------------------------------------------------------------------
    -- { "<C-Right>", "<Cmd>BufferNext<CR>", desc = "Next buffer" },
    -- { "<C-Left>", "<Cmd>BufferPrevious<CR>", desc = "Previous buffer" },
    { "<leader>bb", "<Cmd>BufferPick<CR>", desc = "Pick buffer by letter" },
    { "<leader>bgp", "<Cmd>BufferGotoPinned<CR>", desc = "Go to pinned buffer" },
    { "<leader>1", "<Cmd>BufferGoto 1<CR>", desc = "Go to buffer 1" },
    { "<leader>2", "<Cmd>BufferGoto 2<CR>", desc = "Go to buffer 2" },
    { "<leader>3", "<Cmd>BufferGoto 3<CR>", desc = "Go to buffer 3" },
    { "<leader>4", "<Cmd>BufferGoto 4<CR>", desc = "Go to buffer 4" },
    { "<leader>5", "<Cmd>BufferGoto 5<CR>", desc = "Go to buffer 5" },
    { "<leader>6", "<Cmd>BufferGoto 6<CR>", desc = "Go to buffer 6" },
    { "<leader>7", "<Cmd>BufferGoto 7<CR>", desc = "Go to buffer 7" },
    { "<leader>8", "<Cmd>BufferGoto 8<CR>", desc = "Go to buffer 8" },
    { "<leader>9", "<Cmd>BufferGoto 9<CR>", desc = "Go to buffer 9" },
    { "<leader>0", "<Cmd>BufferLast<CR>", desc = "Go to last buffer" },
    -- ---------------------------------------------------------------------------
    -- Management
    -- ---------------------------------------------------------------------------
    { "<leader><delete>", "<Cmd>BufferClose<CR>", desc = "Close buffer" },
    { "<leader>bd", "<Cmd>BufferClose<CR>", desc = "Close buffer" },
    { "<leader>bD", "<Cmd>BufferClose!<CR>", desc = "Force close buffer" },
    { "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Close other buffers" },
    { "<leader>bp", "<Cmd>BufferTogglePin<CR>", desc = "Toggle pin buffer" },
    { "<leader>br", "<Cmd>BufferRestore<CR>", desc = "Restore last closed buffer" },
    { "<leader>bop", "<Cmd>BufferCloseAllButPinned<CR>", desc = "Close all but pinned" },
    { "<leader>bql", "<Cmd>BufferCloseBuffersLeft<CR>", desc = "Close buffers to the left" },
    { "<leader>bqr", "<Cmd>BufferCloseBuffersRight<CR>", desc = "Close buffers to the right" },
    -- Reorder
    -- { "<A-<>", "<Cmd>BufferMovePrevious<CR>", desc = "Move buffer left" },
    -- { "<A->>", "<Cmd>BufferMoveNext<CR>", desc = "Move buffer right" },
    { "<leader>bH", "<Cmd>BufferMovePrevious<CR>", desc = "Move buffer left" },
    { "<leader>bL", "<Cmd>BufferMoveNext<CR>", desc = "Move buffer right" },
    -- ---------------------------------------------------------------------------
    -- Sorting
    -- ---------------------------------------------------------------------------
    { "<leader>bsa", "<Cmd>BufferOrderByName<CR>", desc = "Sort buffers alphabetically" },
    { "<leader>bsd", "<Cmd>BufferOrderByDirectory<CR>", desc = "Sort buffers by directory" },
    { "<leader>bsl", "<Cmd>BufferOrderByLanguage<CR>", desc = "Sort buffers by language" },
    { "<leader>bsn", "<Cmd>BufferOrderByBufferNumber<CR>", desc = "Sort buffers by buffer number" },
  },
  opts = {
    -- Enable/disable animations
    animation = true,
    -- Auto-hide the tabline when there is only one buffer
    auto_hide = true,
    -- Clickable tabs
    clickable = true,
    -- Offset barbar for sidebars like Neo-tree
    sidebar_filetypes = {
      ["neo-tree"] = { event = "BufWipeout", text = "Neo-Tree", align = "left" },
    },
    -- Icon configuration
    icons = {
      preset = "powerline",
      -- Same glyph on both sides, like tmux-themepack: the preset's highlights
      -- color the left one fill-on-tab and the right one tab-on-fill.
      separator = { left = "\u{e0b0}", right = "\u{e0b0}" },
      inactive = { separator = { left = "\u{e0b0}", right = "\u{e0b0}" } },
      separator_at_end = false,
      filetype = { custom_colors = true }
    },
  },
}
