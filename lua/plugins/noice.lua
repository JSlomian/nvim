
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    routes = {
      -- hide messages that contain "Neotree"
      {
        filter = { event = "msg_show", kind = "", find = "Neotree" },
        opts = { skip = true },
      },
      -- (optional) also hide "Neo-tree" variant
      {
        filter = { event = "msg_show", kind = "", find = "Neo-tree" },
        opts = { skip = true },
      },
    },
  },
}

