vim.keymap.set({ 'n', 'i' }, '<C-q>a', function()
  print('hello from lua')
end, { silent = true })
