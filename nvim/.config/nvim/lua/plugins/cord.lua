return {
  "vyfor/cord.nvim",
  build = "./build", -- This is required to compile the plugin
  event = "VeryLazy", -- Loads the plugin after startup to keep things fast
  opts = {
    user_interface = {
      show_status = true, -- Displays "Idle", "Coding", etc.
    },
    display = {
      show_time = true, -- Shows how long you've been in the file
    },
  },
}
