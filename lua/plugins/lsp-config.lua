return {
  {
    "b0o/schemastore.nvim",
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "jsonls", "eslint" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      vim.diagnostic.config({
        virtual_text = {
          severity = {
            min = vim.diagnostic.severity.HINT, -- show all
          },
          spacing = 2,
          format = function(diagnostic)
            local icons = {
              [vim.diagnostic.severity.ERROR] = "󰅚",
              [vim.diagnostic.severity.WARN] = "",
              [vim.diagnostic.severity.INFO] = "",
              [vim.diagnostic.severity.HINT] = "󰌶",
            }
            return string.format("%s %s", icons[diagnostic.severity], diagnostic.message)
          end,
        },
        signs = false,
      })
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.ts_ls.setup({ capabilities = capabilities })
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
      lspconfig.eslint.setup({
        capabilities = capabilities,
        settings = {
          workingDirectory = { mode = "location" },
          codeAction = { disableRuleComment = { enable = true }, showDocumentation = { enable = true } },
          format = true,
        },
      })
      lspconfig.phpactor.setup({ capabilities = capabilities })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Documentation" })
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Help" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })
      vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
    end,
  },
}
