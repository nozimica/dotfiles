return {
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      explorer = { enabled = false },
      picker = {
        exclude = {
          "node_modules", "build", "dist", ".git", "__pycache__",
          "*.class", ".gradle", "env", "logs",
        },
      },
    },
  },
}
