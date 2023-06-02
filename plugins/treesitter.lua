return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
  },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "rust", "nix" },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      endwise = {
        enable = true,
      },
    }
  end,
}
