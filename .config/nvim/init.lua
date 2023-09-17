
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
   -- use 'EdenEast/nightfox.nvim'         -- Color scheme
    use{
        "catppuccin/nvim",
        as = "catppuccin"
    }
    use { 'rose-pine/neovim', as = 'rose-pine' }
    use 'xiyaowong/nvim-transparent'     -- Transparency enable/disable
    use 'norcalli/nvim-colorizer.lua'    -- Display colors in Vim

    -- Notes
    -- =========================================================================
    -- use {
    --     'vimwiki/vimwiki',
    --     -- vimwiki config: nvim/lua/config/wiki.lua
    --     config = function() require("config.wiki") end
    -- }
    -- use 'tbabej/taskwiki'   -- TaskWarrior integration
    -- Rust
    -- =========================================================================
    use 'rust-lang/rust.vim'
    -- Extra rust analyzer functionality
    use 'simrat39/rust-tools.nvim'

    -- Markdown
    -- =========================================================================
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
        ft = {'markdown'}
    }

    -- Code Editing (IDE)
    -- =========================================================================
    -- Code commenting
    use {
        'numToStr/Comment.nvim',
        config = function()
           require('Comment').setup()
        end
    }
    use 'tpope/vim-fugitive'                           -- Git integration
    use 'plasticboy/vim-markdown'                      -- Markdown support
    use 'tpope/vim-surround'                           -- Change text surrounds
    use 'junegunn/fzf.vim'                             -- Fuzzy searching
    use 'justinmk/vim-sneak'                           -- Text search

    use 'nvim-treesitter/nvim-treesitter'              -- Highlight, edit, and navigate code using a fast incremental parsing library
    use 'nvim-treesitter/nvim-treesitter-textobjects'  -- Additional textobjects for treesitter


    -- LSP/Autocomplete + Snippets
    -- =========================================================================
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'}
        },
        -- cmp config: nvim/lua/config/cmp.lua
        config = function() require("config.cmp") end
    }
    use { 'saadparwaiz1/cmp_luasnip' }
    use {
        'L3MON4D3/LuaSnip',
        after = 'nvim-cmp',
    }
    use 'nvim-lua/lsp_extensions.nvim'  -- Collection of configurations for built-in LSP client
    -- Extensions to built-in LSP, for example, providing type inlay hints
    use {
        'neovim/nvim-lspconfig',
        -- lsp config: nvim/lua/config/lsp.lua
        -- config = function() require("config.lsp") end
    }
    -- Status line
    -- =========================================================================
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
end)

-- =============================================================================
-- Colorscheme {{{1
-- =============================================================================

-- setup must be called before loading
vim.o.termguicolors = true
-- vim.o.background = "dark"
-- vim.g.catppuccin_flavour = "mocha"
-- vim.cmd("colorscheme catppuccin")
-- require('lualine').setup {
--   options = {
--     theme = 'catppuccin'
--   }
-- }

-- =============================================================================
-- Options {{{1
-- =============================================================================
-- Make sure the updated leader mapping is done early
vim.g.mapleader = ' '           -- Map leader to space

-- editor settings: nvim/lua/editor.lua
require('editor')

-- gui settings: nvim/lua/gui.lua
require('gui')

-- key mappings: nvim/lua/keymap.lua
require('keymap')

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

require('rose-pine').setup({
    --- @usage 'auto'|'main'|'moon'|'dawn'
    variant = 'moon',
    --- @usage 'main'|'moon'|'dawn'
    dark_variant = 'moon',
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = false,
    disable_float_background = false,
    disable_italics = false,

    --- @usage string hex value or named color from rosepinetheme.com/palette
    groups = {
        background = 'base',
        background_nc = '_experimental_nc',
        panel = 'surface',
        panel_nc = 'base',
        border = 'highlight_med',
        comment = 'muted',
        link = 'iris',
        punctuation = 'subtle',

        error = 'love',
        hint = 'iris',
        info = 'foam',
        warn = 'gold',

        headings = {
            h1 = 'iris',
            h2 = 'foam',
            h3 = 'rose',
            h4 = 'gold',
            h5 = 'pine',
            h6 = 'foam',
        }
        -- or set all headings at once
        -- headings = 'subtle'
    },

    -- Change specific vim highlight groups
    -- https://github.com/rose-pine/neovim/wiki/Recipes
    highlight_groups = {
        ColorColumn = { bg = 'rose' },

        -- Blend colours against the "base" background
        CursorLine = { bg = 'foam', blend = 10 },
        StatusLine = { fg = 'love', bg = 'love', blend = 10 },

        -- By default each group adds to the existing config.
        -- If you only want to set what is written in this config exactly,
        -- you can set the inherit option:
        Search = { bg = 'gold', inherit = false },
    }
})

-- Set colorscheme after options
vim.cmd('colorscheme rose-pine')
