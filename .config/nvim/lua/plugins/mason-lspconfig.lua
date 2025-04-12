local all_configs = {
  -- lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
}

local function lsp_setup(server)
  local config = { capabilities = vim.lsp.protocol.make_client_capabilities() }
  if all_configs[server] then config = vim.tbl_deep_extend("force", config, all_configs[server]) end
  local old_on_attach = require("lspconfig")[server].on_attach
  config.on_attach = function(client, bufnr)
    if type(old_on_attach) == "function" then old_on_attach(client, bufnr) end
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFromattingProvider = false
  end
  require("lspconfig")[server].setup(config)
end

---@type LazySpec
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = {
      "lua_ls",
    },
    handlers = {
      lsp_setup,
    },
  },
}
