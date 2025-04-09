return {
  'akinsho/bufferline.nvim',
  lazy = false,
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(_, _, diag, _)
        local indicator = ' '
        for level, number in pairs(diag) do
          local symbol
          if level == 'error' then
            symbol = ' '
          elseif level == 'warning' then
            symbol = ' '
          else
            symbol = ' '
          end
          indicator = indicator .. number .. symbol
        end
        return indicator
      end,
    },
  },
  keys = {
    { '<leader>bp', ':BufferLineCyclePrev<CR>', silent = true },
    { '<leader>bn', ':BufferLineCycleNext<CR>', silent = true },
    { '<leader>bk', ':BufferLinePick<CR>', silent = true },
    { '<leader>bc', ':BufferLinePickClose<CR>', silent = true },
    { '<leader>bd', ':bdelete<CR>', silent = true },
    { '<leader>bo', ':BufferLineCloseOthers<CR>', silent = true },
  },
}
