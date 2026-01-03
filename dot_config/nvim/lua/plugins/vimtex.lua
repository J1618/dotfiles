return {
  "lervag/vimtex",
  -- This is the key for optimization: the plugin will only load for these file types
  ft = { "tex", "plaintex", "bib" },
  lazy = false,
  config = function()
    -- Configuration for vimtex goes here
    vim.g.vimtex_view_method = "general"
    vim.g.vimtex_view_general_viewer = "SumatraPDF"
    vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
    vim.g.vimtex_compiler_method = "latexmk"

    -- This setting is crucial for inverse search (PDF to Neovim) on Windows
    vim.g.vimtex_compiler_latexmk = {
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      hooks = {},
      options = {
        "-pdf",
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
  end,
}
