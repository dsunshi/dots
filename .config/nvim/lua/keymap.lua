-- Function to map keys
local map = vim.api.nvim_set_keymap
-- noremap is definitly a safe bet here
local default_opts = {noremap = true}

-- telescope settings
-- ==================

-- Search hidden folders, but not .git
map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", default_opts)

map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", default_opts)
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>",   default_opts)
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", default_opts)
map('n', '<leader>gs', "<cmd>lua require'telescope.builtin'.git_status()<cr>",  default_opts)

map('n', '<leader>dd', "<cmd>lua vim.diagnostic.open_float()<cr>",  default_opts)
map('t', '<ESC>', "<C-\\><C-n>", default_opts)
-- vim.api.nvim_set_keymap(  't'  ,  '<Leader><ESC>'  ,  '<C-\\><C-n>'  ,  {noremap = true}  )

-- disable F-15
vim.cmd('noremap <F15> <Nop>')
vim.cmd('inoremap <F15> <Nop>')
