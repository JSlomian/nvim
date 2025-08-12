return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        -- Core
        "lua",
        "vim",
        "vimdoc",
        -- Markup
        "markdown",
        "markdown_inline",
        -- Web / Node
        "javascript",
        "typescript",
        "tsx",
        "json",
        "html",
        "css",
        "jsdoc",
        -- PHP
        "php",
        "phpdoc",
        -- Other
        "bash",
        "yaml",
        "dockerfile",
        "query",
        "comment",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })
  end,
}
