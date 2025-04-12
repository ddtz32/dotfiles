---@type LazySpec
return {
  "williamboman/mason.nvim",
  lazy = false,
  keys = {
    { "<Leader>pm", "<Cmd>Mason<cr>", desc = "Mason installer" },
  },
  opts = {
    ui = {
      width = vim.g.width,
      height = vim.g.height,
      border = vim.g.border,
      icons = {
        package_installed = "✓",
        package_uninstalled = "✗",
        package_pending = "⟳",
      },
    },
  },
}
