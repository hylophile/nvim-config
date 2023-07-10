--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, and understand
  what your configuration is doing.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  { 'fedepujol/move.nvim' },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    opts = {},
  },
  -- { 'simrat39/inlay-hints.nvim' },
  { 'simrat39/rust-tools.nvim', event = 'BufEnter *.rs', opts = {
    tools = {
      inlay_hints = {
        only_current_line = true,
      },
    },
  } },
  { 'sbdchd/neoformat' },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- { -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },
  { 'mg979/vim-visual-multi' },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      flavour = 'latte',
    },
    -- config = function()
    --   require('catppuccin').setup()
    --   -- vim.cmd.colorscheme 'catppuccin-mocha'
    -- end,
  },
  { 'rebelot/kanagawa.nvim' },
  -- {
  -- 'kamwitsta/flatwhite-vim',
  -- priority=1000,
  -- config=function ()
  --   vim.cmd.colorscheme 'flatwhite'
  -- end,
  -- },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'TimUntersberger/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
      use_magit_keybindings = true,
      disable_commit_confirmation = true,
      disable_insert_on_commit = false,
      mappings = {
        status = {
          ['<ESC>'] = 'Close',
        },
      },
    },
  },
  { 'Pocco81/true-zen.nvim' },

  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {}
      require('telescope').load_extension 'projects'
    end,
  },

  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  {
    'ggandor/flit.nvim',
    config = function()
      require('flit').setup()
    end,
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  { 'rmagatti/auto-session' },
  { 'RRethy/vim-illuminate' },
  { 'nvim-treesitter/playground' },
  {
    dir = '~/code/misc/flatwhite.nvim',
    config = function()
      -- require('flatwhite').setup()
      vim.cmd.colorscheme 'flatwhite'
    end,
  },
  { 'norcalli/nvim-colorizer.lua' },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

vim.o.splitbelow = true
vim.o.splitright = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.title = true
-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'help', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aF'] = '@call.outer',
        ['iF'] = '@call.inner',
        ['ax'] = '@block.outer',
        ['a='] = '@assignment.outer',
        -- ['ay'] = '@statement.outer',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['av'] = '@conditional.outer',
        ['iv'] = '@conditional.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['ak'] = '@key.outer',
        ['ik'] = '@key.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['gza'] = '@parameter.inner',
      },
      swap_previous = {
        ['gzA'] = '@parameter.inner',
      },
    },
  },
}

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

nmap('<leader>cr', vim.lsp.buf.rename, '[R]ename')
nmap('<leader>ca', vim.lsp.buf.code_action, 'Code [A]ction')
nmap('<leader>cx', vim.diagnostic.open_float)
nmap('<leader>ce', vim.diagnostic.setloclist)

nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
nmap('<leader>cD', vim.lsp.buf.type_definition, 'Type [D]efinition')
nmap('<leader>cS', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
nmap('<leader>cs', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

-- See `:help K` for why this keymap
nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

-- Lesser used LSP functionality
nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
nmap('<leader>cFa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
nmap('<leader>cFr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
nmap('<leader>cFl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, '[W]orkspace [L]ist Folders')
-- local on_attach = function(c, bufnr)
--   -- require('inlay-hints').on_attach(c, bufnr)
--   -- NOTE: Remember that lua is a real programming language, and as such it is possible
--   -- to define small helper and utility functions so you don't have to repeat yourself
--   -- many times.
--   --
--   -- In this case, we create a function that lets us more easily define mappings specific
--   -- for LSP related items. It sets the mode, buffer and description for us each time.
--
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     vim.lsp.buf.format()
--   end, { desc = 'Format current buffer with LSP' })
-- end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  pyright = {},
  -- rust_analyzer = {},
  tsserver = {},
  svelte = {},
  tailwindcss = {},
  eslint = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      -- on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

if vim.g.neovide then
  vim.o.guifont = 'Agave:h14' -- text below applies for VimScript
  vim.g.neovide_cursor_vfx_mode = 'torpedo'
  -- vim.g.neovide_cursor_vfx_particle_lifetime = 1.0
  --
  --

  vim.keymap.set('n', '<S-Insert>', '"*P') -- Paste normal mode
  vim.keymap.set('i', '<S-Insert>', '"*P') -- Paste normal mode

  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  local scale_factor = 1.1

  vim.keymap.set('n', '<C-=>', function()
    vim.g.neovide_scale_factor = 1.0
  end)
  vim.keymap.set('n', '<C-+>', function()
    change_scale_factor(scale_factor)
  end)
  vim.keymap.set('n', '<C-->', function()
    change_scale_factor(1 / scale_factor)
  end)
end

local leadermap = function(keys, func, desc)
  desc = desc or func

  vim.keymap.set('n', '<leader>' .. keys, func, { desc = desc })
end

local leadercmdmap = function(keys, func, desc)
  leadermap(keys, '<cmd>' .. func .. '<CR>', desc)
end

local leader_prefix = function(key, name)
  require('which-key').register({
    [key] = {
      name = name,
    },
  }, { prefix = '<leader>' })
end
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })

leader_prefix('i', 'insert')
leadercmdmap('ir', 'Telescope registers')

leadercmdmap('pp', 'Telescope projects')

leadermap(',', require('telescope.builtin').buffers, 'buffers') --, { desc = '[,] Find existing buffers' })
-- See `:help telescope.builtin`
-- F : File
leader_prefix('f', 'files')
leadermap('fr', require('telescope.builtin').oldfiles, 'recent files')
leadermap('fs', '<cmd>write<CR>', 'save file')
leadermap('fg', require('telescope.builtin').git_files)
leadermap('fp', "<cmd>lua require('telescope.builtin').find_files { cwd = '~/.config/nvim' }<CR>", 'config files')

leader_prefix('t', 'toggle')
leadercmdmap('tt', 'split +terminal') -- not really toggling
leadercmdmap('tn', 'ColorizerToggle')

leader_prefix('q', 'quit')
leadermap('qq', '<cmd>quitall<CR>', 'quit')

leadermap('cf', function()
  vim.cmd 'Format'
  vim.cmd 'write'
end)

leader_prefix('<Tab>', 'tabs')
leadermap('<Tab>n', '<cmd>tabnew<CR>', 'new tab')
leadermap('<Tab>d', '<cmd>tabclose<CR>', 'close tab')
vim.keymap.set('n', '<M-1>', '1gt')
vim.keymap.set('n', '<M-2>', '2gt')
vim.keymap.set('n', '<M-3>', '3gt')
vim.keymap.set('n', '<M-4>', '4gt')
vim.keymap.set('n', '<M-5>', '5gt')
vim.keymap.set('n', '<M-6>', '6gt')
vim.keymap.set('n', '<M-7>', '7gt')
vim.keymap.set('n', '<M-8>', '8gt')
vim.keymap.set('n', '<M-9>', '9gt')

leader_prefix('w', 'windows')
leadercmdmap('wv', 'vsplit')
leadercmdmap('ws', 'split')
leadercmdmap('wx', 'split')
leadercmdmap('wd', 'quit')
leadercmdmap('wq', 'quit')
leadercmdmap('wc', 'quit')
leadercmdmap('w<Left>', 'wincmd h')
leadercmdmap('w<Down>', 'wincmd j')
leadercmdmap('w<Up>', 'wincmd k')
leadercmdmap('w<Right>', 'wincmd l')
leadercmdmap('wh', 'wincmd h')
leadercmdmap('wj', 'wincmd j')
leadercmdmap('wk', 'wincmd k')
leadercmdmap('wl', 'wincmd l')
leadercmdmap('ww', 'wincmd w')
leadercmdmap('wW', 'wincmd W')
leadercmdmap('wt', 'wincmd t')
leadercmdmap('wb', 'wincmd b')
leadercmdmap('wp', 'wincmd p')
leadercmdmap('wr', 'wincmd r')
leadercmdmap('wR', 'wincmd R')
leadercmdmap('w=', 'wincmd =')

leader_prefix('c', 'LSP')

leadermap('<Space>', '<cmd>Telescope find_files<CR>')
-- leadermap("<Space>", "<cmd>lua require('telescope.builtin').git_files{ show_untracked = true }<CR>")
leadermap('.', '<cmd>Telescope file_browser path=%:p:h<CR>')

leadermap("'", "<cmd>lua require('telescope.builtin').resume{}<CR>")

leader_prefix('b', 'buffers')
leadermap('bb', "<cmd>lua require('telescope.builtin').buffers{ show_all_buffers = true }<CR>", 'list all buffers')
-- H : Help
leader_prefix('h', 'help')
leadermap('hk', "<cmd>lua require('telescope.builtin').keymaps{}<CR>", 'keys')
leadermap('ha', require('telescope.builtin').help_tags, 'apropos')
-- S : Search
--

leader_prefix('g', 'git')
leadercmdmap('gg', 'Neogit')

leader_prefix('s', 'search')
leadermap('sp', "<cmd>lua require('telescope.builtin').live_grep{}<CR>", 'search project')
leadermap('/', "<cmd>lua require('telescope.builtin').live_grep{}<CR>", 'search project')
leadermap('sr', "<cmd>lua require('telescope.builtin').lsp_references{}<CR>") -- ???
leadermap('ss', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols{}<CR>")
leadermap('sb', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find<CR>")
leadercmdmap('st', 'Telescope')
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })

vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- L : Lists
leadermap('ll', "<cmd>lua require('telescope.builtin').loclist{}<CR>")
leadermap('ll', "<cmd>lua require('telescope.builtin').loclist{}<CR>")
leadermap('lq', "<cmd>lua require('telescope.builtin').quickfix{}<CR>")

vim.keymap.set('n', '<leader>lt', function()
  vim.cmd ':Telescope'
end)

leadermap('ht', "<cmd>lua require('telescope.builtin').colorscheme{}<CR>")

-- vim.g.title

vim.keymap.set('n', '<leader>sb', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find {}
end, { desc = 'search buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float)
-- vim.keymap.set('n', '<leader>eq', vim.diagnostic.setloclist)

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = true,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.cmd ':Neoformat'
  end,
})

-- vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--   pattern = { '*.rs' },
--   callback = function()
--     require('lsp_extensions').inlay_hints { only_current_line = true }
--   end,
-- })

-- Restore cursor position
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = { '*' },
  callback = function()
    vim.cmd 'silent! normal! g`"zv'
  end,
})

vim.cmd [[autocmd FileType help wincmd L]]

vim.keymap.set('n', '<ESC>', '<cmd>nohls<CR>')
vim.keymap.set('n', '<C-c>', '<cmd>xit<CR>')
vim.keymap.set('n', '<C-k>', '<cmd>q!<CR>')
vim.keymap.set('n', '<F8>', '<cmd>so $VIMRUNTIME/syntax/hitest.vim<CR>')
vim.o.cursorline = true
vim.o.gdefault = true

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = { '*' },
  callback = function()
    vim.cmd 'normal zx'
    vim.cmd 'normal zR'
  end,
})

local opts = { noremap = true, silent = true }

vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Normal-mode commands
vim.keymap.set('n', '<M-Down>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<M-Up>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('n', '<M-Left>', ':MoveHChar(-1)<CR>', opts)
vim.keymap.set('n', '<M-Right>', ':MoveHChar(1)<CR>', opts)

-- Visual-mode commands
vim.keymap.set('v', '<M-Down>', ':MoveBlock(1)<CR>', opts)
vim.keymap.set('v', '<M-Up>', ':MoveBlock(-1)<CR>', opts)
vim.keymap.set('v', '<M-Left>', ':MoveHBlock(-1)<CR>', opts)
vim.keymap.set('v', '<M-Right>', ':MoveHBlock(1)<CR>', opts)

vim.keymap.set({ 'n', 'i' }, '<C-s>', function()
  vim.cmd ':write'
end)

-- set theme according to time
local timer = vim.loop.new_timer()
if timer then
  local light_theme = 'flatwhite'
  local dark_theme = 'catppuccin-mocha'
  local function is_daytime(hour)
    return hour > 8 and hour < 20
  end

  timer:start(
    0,
    600,
    vim.schedule_wrap(function()
      local hour = tonumber(os.date '%H')
      local theme = dark_theme
      if is_daytime(hour) then
        theme = light_theme
      end
      vim.cmd('colorscheme ' .. theme)
    end)
  )
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
