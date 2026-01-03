return {
  {
    "neovim/nvim-lspconfig",
    -- This event triggers the plugin to load only when you open a file,
    -- keeping startup optimized
    event = "User AstroFile",
    opts = {
      servers = {
        -- For LaTeX-specific autocompletion and diagnostics
        texlab = {},
        -- For grammar and style checking
        ltex = {},
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "texlab", "ltex" },
    },
  },
}
