return {
  {
    'chrisgrieser/nvim-spider',
    lazy = true,
    keys = {
      { 'w', 'e', 'b', 'ge' },
    },
    opts = {
      skipInsignificantPunctuation = false,
    },
    init = function()
      vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'ge', "<cmd>lua require('spider').motion('ge')<CR>", { desc = 'Spider-ge' })
    end,
  },
  {
    'chrisgrieser/nvim-various-textobjs',
    opts = { useDefaultKeymaps = true },
    lazy = false,
    init = function()
      vim.keymap.set({ 'o', 'x' }, 'iw', "<cmd>lua require('various-textobjs').subword(true)<CR>")
      vim.keymap.set({ 'o', 'x' }, 'aw', "<cmd>lua require('various-textobjs').subword(false)<CR>")
    end,
  },
}
