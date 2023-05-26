vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

local config = {
  colorscheme = function()
    vim.cmd([[colorscheme tokyonight]])
  end,
  neotree = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    require("neo-tree").setup()
  end,
  lualine = function()
    require('lualine').setup()
  end
}

local keymap = {
  neotree = {
    { "<leader>op", "<cmd>Neotree toggle<cr>", desc = "NeoTree" }
  }
}

local plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = config.colorscheme,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = keymap.neotree,
    config = config.neotree,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = config.lualine,
  },

  -- Dependencies
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "MunifTanjim/nui.nvim" },
}

require("lazy").setup(plugins)
