return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-dragon",
      -- Alternatives: "rose-pine-moon", "tokyonight-night", "catppuccin-mocha"
    },
  },
}
