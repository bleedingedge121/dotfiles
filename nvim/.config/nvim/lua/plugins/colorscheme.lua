return {
  -- Install Catppuccin with your settings
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = false,
      term_colors = false,
      -- Add your other catppuccin options here
    },
  },

  -- Install Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
  },

  
  -- Set the active theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin", -- Change this to "gruvbox" to swap
    },
  },
}
