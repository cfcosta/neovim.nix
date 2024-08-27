require("aider").setup({
  auto_manage_context = false,
  default_bindings = false,
})

vim.api.nvim_set_keymap("n", "<leader>oa", "<cmd>lua AiderOpen()<cr>", { noremap = true, silent = true })
