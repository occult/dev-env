return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- gopls will be automatically installed with mason and loaded with lspconfig
        gopls = {},
      },
    },
  },
}
