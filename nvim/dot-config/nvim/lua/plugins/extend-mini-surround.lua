return {
  {
    {
      "nvim-mini/mini.surround",
      opts = {
        mappings = {
          add = ";;",
          delete = ";d",
          find = ";f",
          find_left = ";F",
          highlight = ";h",
          replace = ";r",
          update_n_lines = ";n",
        },
      },
    },

    -- to release ";" from flash
    {
      "folke/flash.nvim",
      opts = {
        modes = {
          char = {
            keys = { "f", "F", "t", "T" },
          },
        },
      },
    },
  },
}
