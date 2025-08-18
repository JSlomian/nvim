return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        -- -------- PHP --------
        -- Formatter: php-cs-fixer (prefers project-local ./vendor/bin)
        null_ls.builtins.formatting.phpcsfixer.with({
          prefer_local = "vendor/bin",
          -- optional: use only when the project looks PHP-y
          condition = function(utils)
            return utils.root_has_file({ ".php-cs-fixer.php", ".php-cs-fixer.dist.php", "composer.json" })
          end,
        }),

        -- Diagnostics: PHPStan & Psalm (no PHPCS to avoid docblock nags)
        -- null_ls.builtins.diagnostics.phpstan.with({
        --   prefer_local = "vendor/bin",
        --   condition = function(utils)
        --     return utils.root_has_file({ "phpstan.neon", "phpstan.neon.dist", "composer.json" })
        --   end,
        -- }),
        -- null_ls.builtins.diagnostics.psalm.with({
        --   prefer_local = "vendor/bin",
        --   condition = function(utils)
        --     return utils.root_has_file({ "psalm.xml", "psalm.xml.dist", "composer.json" })
        --   end,
        -- }),
      },
    })
    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {desc = "Format file"})
    vim.keymap.set("n", "<M-f>", vim.lsp.buf.format, {desc = "Format file"})
  end,
}
