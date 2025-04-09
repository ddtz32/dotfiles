return {
  'nvim-treesitter/nvim-treesitter',
  main = 'nvim-treesitter.configs',
  envet = 'VeryEvent',
  opts = {
    ensure_installed = { 'lua', 'toml', 'cpp', 'cmake' },
    highlight = {
      enable = true,
    },
  },
}
