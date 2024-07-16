return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "p00f/nvim-ts-rainbow",
    "nvim-treesitter/playground"
  },
  config = function()
    require "nvim-treesitter.configs".setup {
      ensure_installed = { "python", "lua", "rust", "javascript", "sql" },
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_, _)
          -- disable treesitter for buffers that are too big (it's too slow)
          local buffer_size = vim.fn.line2byte(vim.fn.line("$") + 1) - 1
          return buffer_size > 300 * 1024 -- 300KB
        end
      },
      rainbow = { enable = true }, -- enable nvim-ts-rainbow
      matchup = { enable = true }, -- enable andymass/vim-matchup
      indent = { enable = true },
      incremental_selection = { enable = true },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,        -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
      }
    }

    -- Temporarily use my own treesitter dockerfile parser
    -- TODO remove this once/if PR is accepted
    -- https://github.com/camdencheek/tree-sitter-dockerfile/pull/24
    --
    -- only takes effect after rerunning :TSInstall dockerfile
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.dockerfile = {
      install_info = { url = "~/repos/tree-sitter-dockerfile", files = { "src/parser.c" } }
    }
  end
}
