return {
  -- "rktjmp/hotpot.nvim",
  -- "Olical/aniseed",
  -- { "eraserhd/parinfer-rust", build = "cargo build --release" },
  {
    'Olical/conjure',
  },
  {
    'clojure-vim/vim-jack-in',
    dependencies = {
      'tpope/vim-dispatch',
      'radenling/vim-dispatch-neovim',
    },
  },
  {
    'gpanders/nvim-parinfer',
    config = function()
      vim.g.parinfer_force_balance = true
      vim.g.parinfer_filetypes = {
        -- Defaults
        'clojure',
        'scheme',
        'lisp',
        'racket',
        'hy',
        'fennel',
        'janet',
        'carp',
        'wast',
        'yuck',
      }
    end,
  },
}
