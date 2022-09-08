local set_keymap = require('utils').set_keymap

-- tolerate some typos on file related commands
  -- apparently, there's no equivalent to the "cnoreabbrev" in lua
  -- https://github.com/nanotee/nvim-lua-guide/issues/37
abbrev_translations = {
  'W! w!', 'Q! q!', 'Qall! qall!', 'Qa! qa!', 'Wq wq', 'Wa wa',
  'wQ wq', 'WQ wq', 'W w', 'Q q', 'Qa qa', 'Qall qall',
}
for _, entry in pairs(abbrev_translations) do
  vim.cmd(string.format("cnoreabbrev %s", entry))
end

-- The PC is fast enough, do syntax highlight syncing from start
-- TODO probably remove this if start using treesitter
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = ":syntax sync fromstart",
})

vim.g.mapleader     = ','                    -- leader
vim.opt.clipboard   = 'unnamed,unnamedplus'  -- use standard clipboard
vim.opt.hidden      = true                   -- Enable hidden buffers
vim.opt.diffopt:append {'iwhite'}            -- ignore whitespace in vimdiff

-- Searching
vim.opt.ignorecase  = true
vim.opt.smartcase   = true

-- tabstops (may be overriten by autocmd rules)
vim.opt.tabstop     = 2
vim.opt.softtabstop = 0
vim.opt.shiftwidth  = 2
vim.opt.expandtab   = true

set_keymap('n', '<leader><space>', ':noh<cr>')  -- clear search highlight
set_keymap('n', '<Tab>', ':bn<cr>')             -- buffer nav
set_keymap('n', '<S-Tab>', ':bp<cr>')           -- buffer nav
set_keymap('n', '<leader>c', ':bd<cr>')         -- close buffer
set_keymap('n', '<leader>e', ':FZF<cr>')        -- open file with fzf

-- maintain Visual Mode after shifting > and <
set_keymap('v', '<', '<gv')
set_keymap('v', '>', '>gv')

-- toggle spell check
set_keymap('', '<F6>', ':syntax on<CR>:setlocal spell! spelllang=en_us<CR>')

-- configure CrispyDrone/vim-tasks
-- TODO run this only on CrispyDrone/vim-tasks context
-- for https://github.com/CrispyDrone/vim-tasks#add-tasks
vim.g.maplocalleader = ' '
vim.g.TasksDateFormat = ''  -- no time marks for @done

-- junegunn/vim-easy-align
set_keymap('n', 'ga', '<Plug>(EasyAlign)')
set_keymap('x', 'ga', '<Plug>(EasyAlign)')

-- grep.vim
set_keymap('n', '<leader>f', ':Rgrep<CR>')
vim.g.Grep_Default_Options = '-IR'
vim.g.Grep_Skip_Files = '*~ ipython_log.py*'
vim.g.Grep_Skip_Dirs = 'RCS CVS SCCS htmlcov .pytest_cache .mypy_cache zz'
