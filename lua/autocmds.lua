
-- lua/autocmds.lua

local grp = vim.api.nvim_create_augroup("PhpDocblock", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = "php",
  callback = function(args)
    local bufnr = args.buf

    -- PhpStorm-like continuation inside the block
    vim.opt_local.formatoptions:append("croq")
    vim.opt_local.comments = { "s1:/*", "mb:* ", "ex:*/" }
    vim.bo[bufnr].autoindent = true

    -- Clean any previous mapping for this buffer
    pcall(vim.api.nvim_buf_del_keymap, bufnr, "i", "<CR>")

    -- When pressing <CR> right after '/**', create a docblock skeleton,
    -- keep cursor on the middle line, and respect current indent.
    vim.keymap.set("i", "<CR>", function()
      local row, col = table.unpack(vim.api.nvim_win_get_cursor(0)) -- row:1-based, col:0-based
      local line     = vim.api.nvim_get_current_line()
      local before   = line:sub(1, col)

      if before:match("/%*%*%s*$") then
        local indent = line:match("^%s*") or ""

        -- Let Neovim handle the newline & " * " via formatoptions,
        -- then append the closing line on the next tick.
        vim.schedule(function()
          -- After <CR>, we're on the " * " line. Insert the closer below it.
          local cur_row = vim.api.nvim_win_get_cursor(0)[1]         -- 1-based
          vim.api.nvim_buf_set_lines(0, cur_row, cur_row, false, { indent .. " */" })
          -- Place cursor after " * " on the middle line
          vim.api.nvim_win_set_cursor(0, { cur_row, #indent + 3 })
        end)

        return "\n"
      end

      return "\n"
    end, { buffer = bufnr, expr = true, noremap = true, silent = true })
  end,
})

