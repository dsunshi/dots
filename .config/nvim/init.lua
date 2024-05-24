
-- =============================================================================
-- Plugins {{{1
-- =============================================================================
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- Have Packer manage itself
    use { 'wbthomason/packer.nvim', opt = true }
	use { 'freitass/todo.txt-vim' }

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
    -- Rust
    use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'
    use 'tpope/vim-commentary'
    use 'sirtaj/vim-openscad'
    --
    -- Haskell
    use {
        'mrcjkb/haskell-tools.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'mfussenegger/nvim-dap'} -- generic neovim <-> debugger connection
        }
    }

    --
    --
    use 'ixru/nvim-markdown'
    use 'dhruvasagar/vim-table-mode'

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
vim.g.maplocalleader = ','      -- Map leader to space

-- setup must be called before loading
vim.o.termguicolors = true

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

vim.cmd('autocmd FileType openscad setlocal commentstring=\\/\\/\\ %s')
-- =============================================================================
-- Colorscheme {{{1
-- =============================================================================

-- Set colorscheme after options
vim.cmd('colorscheme nord')
