
-- =============================================================================
-- Plugins {{{1
-- =============================================================================
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- Have Packer manage itself
    use { 'wbthomason/packer.nvim', opt = true }

    -- Searching
    -- =========================================================================
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'lewis6991/gitsigns.nvim',
         config = function()
           require('gitsigns').setup()
         end
    }
    -- Appearance
    -- =========================================================================
    use 'norcalli/nvim-colorizer.lua'    -- Display colors in Vim
    use 'shaunsingh/nord.nvim'

    -- General Editing
    -- =========================================================================
    use 'godlygeek/tabular'

    -- Code Editing (IDE)
    -- =========================================================================
    use 'tpope/vim-commentary'
    use 'sirtaj/vim-openscad'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    --
    -- Haskell
    use {
        'mrcjkb/haskell-tools.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'mfussenegger/nvim-dap'} -- generic neovim <-> debugger connection
        }
    }

    -- Language independent
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    --
    --
    use 'ixru/nvim-markdown'
    use 'dhruvasagar/vim-table-mode'
    use 'godlygeek/tabular'

    -- Status line
    -- =========================================================================
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
end)

-- =============================================================================
-- Options {{{1
-- =============================================================================
-- Make sure the updated leader mapping is done early
vim.g.mapleader = ' '           -- Map leader to space
vim.g.maplocalleader = ','      -- Map local leader to space

-- setup must be called before loading
vim.o.termguicolors = true

-- editor settings: nvim/lua/editor.lua
require('editor')

-- gui settings: nvim/lua/gui.lua
require('gui')

-- key mappings: nvim/lua/keymap.lua
require('keymap')

require('cmp')

-- Disable folding in markdown since it is more of a pain than anything
vim.g.vim_markdown_folding_disabled = 1

require('rust-tools').setup(opts)
vim.g.rustfmt_autosave = true   -- Format rust code when the buffer is saved

-- Automatic, language-dependent indentation, syntax coloring and other
-- functionality.
--
-- Must come *after* the `:packadd!` calls above otherwise the contents of
-- package "ftdetect" directories won't be evaluated.
vim.cmd('filetype indent plugin on')
vim.cmd('syntax on')

vim.cmd('autocmd FileType openscad setlocal commentstring=\\/\\/\\ %s')
-- =============================================================================
-- Colorscheme {{{1
-- =============================================================================

-- Set colorscheme after options
vim.cmd('colorscheme nord')


-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
  end,
},
window = {
  -- completion = cmp.config.window.bordered(),
  -- documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    -- Add tab support
    ['<Tab>'] = cmp.mapping(function(fallback)
      local luasnip = require('luasnip')
      if not luasnip then
          return
      end
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      local luasnip = require('luasnip')
      if not luasnip then
          return
      end
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
}),
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  -- { name = 'vsnip' }, -- For vsnip users.
  { name = 'luasnip' }, -- For luasnip users.
  -- { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
}, {
  { name = 'buffer' },
})
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'git' },
}, {
  { name = 'buffer' },
})
})
require("cmp_git").setup() ]]-- 

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
}),
matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['hls'].setup {
  capabilities = capabilities
}
