return {
  'saghen/blink.cmp',
  version = '*',
  event = 'VeryLazy',
  dependencies = 'rafamadriz/friendly-snippets',
  opts = {
    completion = {
      documentation = {
        auto_show = true,
      },
    },
    keymap = {
      preset = 'super-tab',
    },
    sources = {
      default = { 'path', 'snippets', 'buffer', 'lsp' },
    },
    cmdline = {
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == '/' then
          return { 'buffer' }
        end
        if type == ':' then
          return { 'cmdline' }
        end
        return {}
      end,
      keymap = {
        preset = 'super-tab',
      },
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },
  },
}
