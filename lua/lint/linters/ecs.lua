local severities = {
  ERROR = vim.diagnostic.severity.ERROR,
  WARNING = vim.diagnostic.severity.WARN,
}

local bin = 'ecs'

return {
  cmd = function()
    local local_bin = vim.fn.fnamemodify('vendor/bin/' .. bin, ':p')
    return vim.loop.fs_stat(local_bin) and local_bin or bin
  end,
  stdin = true,
  args = {
    'check',
    '--quiet',
    '--format=json',
    function()
      return vim.fn.expand('%:p')
    end,
  },
  ignore_exitcode = true, -- ECS exits nonzero when it finds issues
  parser = function(output, _)
    if not output or vim.trim(output) == '' then
      return {}
    end

    local ok, decoded = pcall(vim.json.decode, output)
    if not ok or not decoded or not decoded.files then
      return {}
    end

    local diagnostics = {}

    for _, file in pairs(decoded.files) do
      for _, msg in ipairs(file.messages or {}) do
        table.insert(diagnostics, {
          lnum = (msg.line or 1) - 1,
          end_lnum = (msg.line or 1) - 1,
          col = (msg.column or 1) - 1,
          end_col = (msg.column or 1) - 1,
          message = msg.message,
          code = msg.source,
          source = bin,
          severity = severities[(msg.severity or 'ERROR'):upper()] or vim.diagnostic.severity.ERROR,
        })
      end
    end

    return diagnostics
  end,
}
