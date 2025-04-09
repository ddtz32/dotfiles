return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local registry = require('mason-registry')
    local function install(server)
      local success, package = pcall(registry.get_package, server)
      if success and not package:is_installed() then
        package:install()
      end
    end

    local servers = {
      'stylua',
      'clang-format',
    }
    for _, server in ipairs(servers) do
      install(server)
    end

    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting["clang-format"start],
      },
    })
  end,
  keys = {
    { '<leader>lf', vim.lsp.buf.format },
  },
}
