return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,                  -- smarter pair rules from Treesitter
    map_cr = true,                    -- <CR> -> newline + indent inside pairs
    enable_check_bracket_line = false,
    fast_wrap = {},                   -- optional: Alt-e wrap word/selection
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    -- blink.cmp integration
    local ok, blink = pcall(require, "blink.cmp")
    if ok then
      blink.setup({
        completion = {
          accept = {
            auto_brackets = { enabled = true }, -- autopairs after completion
          },
        },
      })
    end
  end,
}
