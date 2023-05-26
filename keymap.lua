return {
  neotree = {
    { "<leader>op", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  telescope = {
    { "<leader><leader>", "<cmd> Telescope find_files hidden=true<CR>" },
    { "<leader>/", "<cmd> Telescope live_grep <CR>" },
    { "<leader>bb", "<cmd> Telescope buffers <CR>" },
    { "<leader>cm", "<cmd> Telescope git_commits <CR>" },
    { "<leader>gt", "<cmd> Telescope git_status <CR>" },
  },
  lsp = {
    { "gD", vim.lsp.buf.declaration },
    { "gd", vim.lsp.buf.definition },
    { "K", vim.lsp.buf.hover },
    { "gi", vim.lsp.buf.implementation },
    { "<leader>ls", vim.lsp.buf.signature_help },
    { "<leader>D", vim.lsp.buf.type_definition },
    { "<leader>ca", vim.lsp.buf.code_action },
    { "gr", vim.lsp.buf.references },
    { "<leader>f", vim.diagnostic.open_float },
    { "[d", vim.diagnostic.goto_prev },
    { "d]", vim.diagnostic.goto_next },
    { "<leader>q", vim.diagnostic.setloclist },
    {
      "<leader>rr",
      function()
        require("nvchad_ui.renamer").open()
      end,
    },
  },
}
