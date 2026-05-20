return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        -- HIDDEN FILES
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
          -- CUSTOM PROJECT
          projects = {
            projects = {
              "~/Coding/",
            },
          },
        },
      },
    },
  },
}
