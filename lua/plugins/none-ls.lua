return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local null_ls_utils = require("null-ls.utils")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          prefer_local = "node_modules/.bin",
        }),
        -- null_ls.builtins.diagnostics.make({
        --   name = "rector",
        --   method = null_ls.methods.DIAGNOSTICS,
        --   filetypes = { "php" },
        --   generator = null_ls.generator({
        --     command = "vendor/bin/rector",
        --     args = { "process", "--dry-run", "--output-format=json", "$FILENAME" },
        --     format = "json",
        --     on_output = function(params, done)
        --       local diags = {}
        --
        --       if not params.output or not params.output.files then
        --         return done()
        --       end
        --
        --       for _, file in ipairs(params.output.files) do
        --         for _, diff in ipairs(file.diff or {}) do
        --           table.insert(diags, {
        --             row = diff.line or 1,
        --             col = 1,
        --             source = "rector",
        --             message = diff.description or "Rector suggestion",
        --             severity = 2, -- 1=Error, 2=Warning, 3=Info, 4=Hint
        --           })
        --         end
        --       end
        --
        --       done(diags)
        --     end,
        --   }),
        -- }),
        -- ESLint diagnostics + quick fixes (uses your local node_modules/.bin/eslint)
        require("none-ls.diagnostics.eslint").with({
          prefer_local = "node_modules/.bin",
          condition = function(u)
            return u.root_has_file({
              "eslint.config.js",
              "eslint.config.cjs",
              "eslint.config.mjs",
              ".eslintrc",
              ".eslintrc.json",
              ".eslintrc.js",
              ".eslintrc.cjs",
              "package.json",
            })
          end,
        }),
        require("none-ls.code_actions.eslint").with({
          prefer_local = "node_modules/.bin",
        }),
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
    vim.keymap.set("n", "<leader>cf", function()
      vim.lsp.buf.format({
        async = true,
        filter = function(client)
          return client.name == "null-ls"
        end,
      })
    end, { desc = "Format file" })
    vim.keymap.set("n", "<M-f>", function()
      vim.lsp.buf.format({
        async = true,
        filter = function(client)
          return client.name == "null-ls"
        end,
      })
    end, { desc = "Format file" })
    vim.keymap.set("n", "<leader>cl", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { "source.fixAll.eslint" } },
      })
    end, { desc = "ESLint: Fix all (LSP)" })
  end,
}
