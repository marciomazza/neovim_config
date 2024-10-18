return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      checkbox = {
        checked = { scope_highlight = "@markup.strikethrough" },
        position = "overlay",
        custom = {
          todo = {
            raw = "[-]",
            rendered = "󰓎 ",
            highlight = "DiagnosticWarn",
            scope_highlight = "DiagnosticWarn",
          },
        },
      },
    }
  }
}