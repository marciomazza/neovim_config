-- turn off all linters by default
vim.g.ale_linters_explicit = 1  

-- ALE fixers
vim.g.ale_fix_on_save = 1
vim.g.ale_fixers = { ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
                     python = {'autoflake', 'black', 'isort'}}
vim.g.ale_python_black_use_global = 1
vim.g.ale_python_isort_use_global = 1
vim.g.ale_python_isort_options = '--float-to-top --profile black'

vim.g.ale_pattern_options = {
  ['ipython_log.py'] = {ale_enabled = 0, ale_fixers = {}},
  ['site-packages'] = {ale_enabled = 0, ale_fixers = {}},
  repos = {ale_enabled = 0, ale_fixers = {}},
}
