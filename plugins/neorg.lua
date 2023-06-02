return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  event = "VeryLazy",
  cmd = "Neorg",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/Notes",
            },
          },
        },
      },
    }
  end,
}
