return {
  neotree = {
    { "<leader>op", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  telescope = {
    -- find
    { "<leader><leader>", "<cmd> Telescope find_files hidden=true<CR>", desc = "find files" },
    { "<leader>/", "<cmd> Telescope live_grep <CR>", desc = "live grep" },
    { "<leader>bb", "<cmd> Telescope buffers <CR>", desc = "find buffers" },

    -- git
    { "<leader>cm", "<cmd> Telescope git_commits <CR>", desc = "git commits" },
    { "<leader>gt", "<cmd> Telescope git_status <CR>", desc = "git status" },
  },
  lsp = {
    {
      "gD",
      function()
        vim.lsp.buf.declaration()
      end,
      desc = "lsp declaration",
    },
    {
      "gd",
      function()
        vim.lsp.buf.definition()
      end,
      desc = "lsp definition",
    },
    {
      "K",
      vim.lsp.buf.hover,
      desc = "lsp hover",
    },
    {
      "gi",
      function()
        vim.lsp.buf.implementation()
      end,
      desc = "lsp implementation",
    },
    {
      "<leader>ls",
      function()
        vim.lsp.buf.signature_help()
      end,
      desc = "lsp signature_help",
    },
    {
      "<leader>D",
      function()
        vim.lsp.buf.type_definition()
      end,
      desc = "lsp definition type",
    },
    {
      "<leader>rr",
      function()
        require("nvchad_ui.renamer").open()
      end,
      desc = "lsp rename",
    },
    {
      "<leader>ca",
      function()
        vim.lsp.buf.code_action()
      end,
      desc = "lsp code_action",
    },
    {
      "gr",
      function()
        vim.lsp.buf.references()
      end,
      desc = "lsp references",
    },
    {
      "<leader>f",
      function()
        vim.diagnostic.open_float()
      end,
      desc = "floating diagnostic",
    },
    {
      "[d",
      function()
        vim.diagnostic.goto_prev()
      end,
      desc = "goto prev",
    },
    {
      "d]",
      function()
        vim.diagnostic.goto_next()
      end,
      desc = "goto_next",
    },
    {
      "<leader>q",
      function()
        vim.diagnostic.setloclist()
      end,
      desc = "diagnostic setloclist",
    },
  },
}
