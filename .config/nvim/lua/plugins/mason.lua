return {
  'williamboman/mason.nvim',
  -- event = 'VeryLazy',
  lazy = false,
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
  },
  opts = {},
  config = function(_, opts)
    require('mason').setup(opts)

    local registry = require('mason-registry')
    local function install(server, config)
      local success, package = pcall(registry.get_package, server)
      if success and not package:is_installed() then
        package:install()
      end
      local nvim_lsp = require('mason-lspconfig.mappings.server').package_to_lspconfig[server]
      config.capabilities = require('blink.cmp').get_lsp_capabilities()
      config.on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFromattingProvider = false
      end
      require('lspconfig')[nvim_lsp].setup(config)
    end

    local servers = {
      ['lua-language-server'] = {},
      pyright = {},
      clangd = {},
    }
    for server, config in pairs(servers) do
      install(server, config)
    end

    vim.cmd('LspStart')
    vim.diagnostic.config({
      virtual_text = true,
      -- virtual_lines = true, -- virtaul text on new line
      update_in_insert = true,
    })
  end,
}
