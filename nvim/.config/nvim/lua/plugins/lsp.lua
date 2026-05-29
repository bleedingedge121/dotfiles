return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- This adds 'hl' alongside the default 'vim' global
                globals = { "vim", "hl" },
              },
            },
          },
        },
      },
    },
  },
}
