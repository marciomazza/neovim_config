local COMMENTSTRINGS = {
  sql = "-- %s",
  htmldjango = "{# %s #}",
}

return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require "mini.ai".setup()
    require "mini.align".setup()
    require "mini.operators".setup()
    require "mini.pairs".setup()
    require "mini.surround".setup()
    require "mini.jump".setup()
    require "mini.splitjoin".setup()
    require "mini.extra".setup()

    local mini_files = require "mini.files"
    mini_files.setup({
      mappings = { close = "<F2>" }
    })
    vim.keymap.set("n", "<F2>", mini_files.open)

    require "mini.comment".setup {
      options = {
        custom_commentstring = function()
          return COMMENTSTRINGS[vim.bo.filetype] or nil
        end,
      }
    }

    local gen_highlighter = require "mini.extra".gen_highlighter
    require "mini.hipatterns".setup({
      highlighters = {
        todo  = gen_highlighter.words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
        fixme = gen_highlighter.words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
        xxx   = gen_highlighter.words({ "XXX", "xxx" }, "MiniHipatternsHack"),
      },
    })
  end,
}
