local opts = { silent=true }
vim.keymap.set('n', '<C-l>', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- for some strange reason jedi language server completion breaks if this is true
capabilities.textDocument.completion.completionItem.snippetSupport = false

local lspconfig = require 'lspconfig'

plone = require('plone')

lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup,
  function(config)
    local plone_config = plone.get_plone_config()
    if plone_config ~= nil then
      config.root_dir = function() return plone_config.root_dir end
      config.init_options = { workspace = { extraPaths = plone_config.extra_paths } }
    end
  end
)

lspconfig.jedi_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}