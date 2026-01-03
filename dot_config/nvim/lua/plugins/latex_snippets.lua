-- lua/plugins/latex_snippets.lua
return {
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    ft = { "tex", "plaintex" }, -- only load when editing LaTeX files [web:56]
    dependencies = { "L3MON4D3/LuaSnip" },
    config = function()
      -- Use the recommended setup from the plugin
      require("luasnip-latex-snippets").setup {
        use_treesitter = true, -- if you have treesitter for LaTeX installed
      }
    end,
  },
}
