local COMMENTSTRINGS = {
  sql = "-- %s",
  htmldjango = "{# %s #}",
}

local function get_highlighters(gen_highlighter)
  -- switch TODO and HACK highlighters
  local function get_hl(name)
    local data = vim.api.nvim_get_hl(0, { name = name, link = false })
    return { bg = data.bg, fg = data.fg, bold = data.bold }
  end
  local todo_data, hack_data = get_hl("MiniHipatternsTodo"), get_hl("MiniHipatternsHack")
  vim.api.nvim_set_hl(0, "MiniHipatternsTodo", hack_data)
  vim.api.nvim_set_hl(0, "MiniHipatternsHack", todo_data)
  return {
    todo  = gen_highlighter.words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
    fixme = gen_highlighter.words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
    xxx   = gen_highlighter.words({ "XXX", "xxx" }, "MiniHipatternsHack"),
  }
end

local file_explorer_ignored = { ".*\\.pyc", "__pycache__" }

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
    require "mini.icons".setup()

    local MiniFiles = require "mini.files"
    local function minifiles_toggle()
      if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
    end
    MiniFiles.setup({
      mappings = { go_in_plus = "<Enter>", go_out_plus = "<Esc>" },
      windows = {
        preview = true,
        width_focus = 20,
        width_preview = 80,
      },
      content = {
        filter = function(fs_entry)
          if vim.startswith(fs_entry.name, ".") then
            return false
          end
          for _, pattern in ipairs(file_explorer_ignored) do
            if vim.fn.match(fs_entry.name, pattern) >= 0 then
              return false
            end
          end
          return true
        end,
      }
    })
    vim.keymap.set("n", "<F3>", minifiles_toggle)

    require "mini.comment".setup {
      options = {
        custom_commentstring = function()
          return COMMENTSTRINGS[vim.bo.filetype] or nil
        end,
      }
    }

    local gen_highlighter = require "mini.extra".gen_highlighter
    require "mini.hipatterns".setup {
      highlighters = get_highlighters(gen_highlighter),
    }

    local MiniPick = require "mini.pick"
    MiniPick.setup()
    vim.ui.select = MiniPick.ui_select
    vim.keymap.set("n", "<leader>f", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end)
    vim.keymap.set("n", "<leader>F", MiniPick.builtin.grep_live)
    vim.keymap.set("n", "<leader>e", MiniPick.builtin.files)
  end,
}
