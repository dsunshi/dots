-- -- nvim-cmp setup
-- local cmp = require('cmp')
-- -- TODO: It would be nice to understand why only a local
-- -- luasnip works v. the 'normal' global, but it does seem to work..
-- -- local luasnip = require('luasnip')

-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

-- cmp.setup({
--   snippet = {
--     expand = function(args)
--         local luasnip = require('luasnip')
--         if not luasnip then
--             return
--         end
--         luasnip.lsp_expand(args.body)
--     end,
--   },
--   mapping = {
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     -- Add tab support
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       local luasnip = require('luasnip')
--       if not luasnip then
--           return
--       end
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       elseif has_words_before() then
--         cmp.complete()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       local luasnip = require('luasnip')
--       if not luasnip then
--           return
--       end
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Insert,
--       select = true,
--     })
--   },

--   -- Installed sources
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--     { name = 'path' },
--     { name = 'buffer' },
--   },
-- })


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
